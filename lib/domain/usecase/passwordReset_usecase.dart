import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class PasswordResetUseCase extends BaseUseCase<PasswordResetUseCaseInput, void> {
  final Repository _repository;

  PasswordResetUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(PasswordResetUseCaseInput input) async {
    return _repository.passwordReset(
      email: input.email,
    );
  }
}

class PasswordResetUseCaseInput {
  final String email;

  PasswordResetUseCaseInput({
    required this.email,
  });
}
