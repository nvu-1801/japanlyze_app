import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/auth/login_usecase.dart';
import '../../../domain/usecases/auth/register_usecase.dart';
import '../../../domain/usecases/auth/get_current_user_usecase.dart';
import '../../../domain/usecases/auth/logout_usecase.dart';
import '../../../domain/usecases/auth/update_profile_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// BLoC for handling authentication state
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final LogoutUseCase _logoutUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required LogoutUseCase logoutUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       _logoutUseCase = logoutUseCase,
       _updateProfileUseCase = updateProfileUseCase,
       super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<GetCurrentUserEvent>(_onGetCurrentUser);
    on<LogoutEvent>(_onLogout);
    on<UpdateUserEvent>(_onUpdateUser);
    on<GoogleLoginEvent>(_onGoogleLogin);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    print('AuthBloc: Login event for ${event.email}');
    emit(AuthLoading());

    final result = await _loginUseCase(
      LoginParams(email: event.email.trim(), password: event.password),
    );

    result.fold(
      (failure) {
        print('AuthBloc: Login failure - ${failure.message}');
        emit(AuthError(failure.message));
      },
      (user) {
        print('AuthBloc: Login success for user ${user.uuid}');
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _registerUseCase(
      RegisterParams(
        name: event.name.trim(),
        email: event.email.trim(),
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onGetCurrentUser(
    GetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _getCurrentUserUseCase(const NoParams());

    result.fold(
      (failure) => emit(AuthUnauthenticated()),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await _logoutUseCase(const NoParams());
    emit(AuthUnauthenticated());
  }

  Future<void> _onUpdateUser(
    UpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      // Don't emit loading here to avoid UI flicker if not needed,
      // or emit a specific "updating" state if wanted.
      // For simplicity, we just call the usecase.

      final result = await _updateProfileUseCase(event.user);

      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthAuthenticated(user)),
      );
    }
  }

  Future<void> _onGoogleLogin(
    GoogleLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    // Using repository directly for Google login simplify the pattern
    // unless a dedicated usecase is strictly required by the user.
    final result = await _loginUseCase.repository.signInWithGoogle();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }
}
