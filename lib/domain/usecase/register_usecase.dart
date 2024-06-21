import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/enums.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RegisterUseCase extends BaseUseCase<RegisterUseCaseInput, void> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(RegisterUseCaseInput input) async {
    return _repository.register(
      username: input.username,
      email: input.email,
      phoneNumber: input.phoneNumber,
      password: input.password,
      gender: input.gender,
      job: input.job,
      salary: input.salary,
      age: input.age,
      martialStatus: input.martialStatus,
      image: input.image,
      userType: input.userType,
    );
  }
}

class RegisterUseCaseInput {
  final String username;
  final String email;
  final String phoneNumber;
  final String? password;
  final Gender gender;
  final String? job;
  final int? salary;
  final int age;
  final String? martialStatus;
  final String? image;
  final UserRole userType;

  RegisterUseCaseInput({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.gender,
    required this.job,
    required this.salary,
    required this.age,
    required this.martialStatus,
    required this.image,
    required this.userType,
  });
}
