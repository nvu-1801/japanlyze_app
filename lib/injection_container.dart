import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dio/dio.dart';

import 'data/datasources/local/user_local_datasource.dart';
import 'data/datasources/remote/auth_remote_datasource.dart';
import 'data/datasources/remote/progress_remote_datasource.dart';
import 'data/datasources/remote/translation_remote_datasource.dart';
import 'data/datasources/remote/history_remote_datasource.dart';
import 'data/datasources/remote/exam_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/auth/login_usecase.dart';
import 'domain/usecases/auth/register_usecase.dart';
import 'domain/usecases/auth/get_current_user_usecase.dart';
import 'domain/usecases/auth/logout_usecase.dart';
import 'domain/usecases/auth/update_profile_usecase.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/dashboard/dashboard_bloc.dart';
import 'data/services/user_progress_service.dart';
import 'data/services/roadmap_sync_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //=== External Dependencies ===//
  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  final connectivity = Connectivity();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => connectivity);

  //=== Core ===//
  sl.registerLazySingleton(() => Supabase.instance.client);

  //=== API Clients ===//
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final session = sl<SupabaseClient>().auth.currentSession;
          if (session?.accessToken != null) {
            options.headers['Authorization'] = 'Bearer ${session!.accessToken}';
          }
          return handler.next(options);
        },
      ),
    );
    return dio;
  });

  //=== Data Sources ===//
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabase: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<ProgressRemoteDataSource>(
    () => ProgressRemoteDataSourceImpl(supabase: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<TranslationRemoteDataSource>(
    () => TranslationRemoteDataSourceImpl(supabase: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<HistoryRemoteDataSource>(
    () => HistoryRemoteDataSourceImpl(supabase: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(secureStorage: sl(), sharedPreferences: sl()),
  );
  sl.registerLazySingleton<ExamRemoteDataSource>(
    () => ExamRemoteDataSource(dio: sl<Dio>(), supabase: sl<SupabaseClient>()),
  );

  //=== Repositories ===//
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      connectivity: sl(),
    ),
  );

  //=== Use Cases ===//
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));

  //=== Services ===//
  sl.registerLazySingleton(() => UserProgressService());
  sl.registerLazySingleton(() => RoadmapSyncService(userLocalDataSource: sl()));

  //=== Blocs ===//
  sl.registerLazySingleton(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      getCurrentUserUseCase: sl(),
      logoutUseCase: sl(),
      updateProfileUseCase: sl(),
      syncService: sl(),
    ),
  );
  sl.registerFactory(
    () => DashboardBloc(authBloc: sl(), progressService: sl(), examDs: sl()),
  );
}
