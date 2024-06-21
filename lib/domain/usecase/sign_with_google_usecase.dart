import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';


class SignWithGoogleUseCase extends BaseUseCase<SignWithGoogleUseCaseInput, User?> {
  final Repository _repository;

  SignWithGoogleUseCase(this._repository);

  @override
  Future<Either<Failure, User?>> call(SignWithGoogleUseCaseInput input) async {
    return _repository.signInWithGoogle();
  }
}
class SignWithGoogleUseCaseInput {}
