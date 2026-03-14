import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class UpdateProfileUseCase implements UseCase<User, User> {
  final AuthRepository _repository;

  UpdateProfileUseCase(this._repository);

  @override
  Future<Either<Failure, User>> call(User user) async {
    return await _repository.updateProfile(user);
  }
}
