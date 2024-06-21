import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/base/base_states.dart';

import '../../../domain/models/enums.dart';
import '../../../domain/usecase/register_usecase.dart';
import '../../base/base_cubit.dart';
import '../../common/data_intent/data_intent.dart';
import '../states/register_states.dart';

class RegisterViewModel extends BaseCubit
    implements RegisterViewModelInput, RegisterViewModelOutput {
  static RegisterViewModel get(context) => BlocProvider.of(context);
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  late UserRole _registerType;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  TextEditingController? _jobController;
  TextEditingController? _salaryController;
  final TextEditingController _ageController = TextEditingController();
  TextEditingController? _martialStatusController;

  User? _fireAuthUser;
  String? _fireAuthUsername;
  String? _fireAuthEmail;
  String? _fireAuthPhoneNumber;

  @override
  void start() {
    _fireAuthUser = DataIntent.popFireAuthUser();
    _fireAuthUsername = _fireAuthUser?.displayName;
    _fireAuthEmail = _fireAuthUser?.email;
    _fireAuthPhoneNumber = _fireAuthUser?.phoneNumber;
    _registerType = DataIntent.getUserRole()!;
    if (_registerType == UserRole.tenant) {
      _jobController = TextEditingController();
      _salaryController = TextEditingController();
      _martialStatusController = TextEditingController();
      emit(RegisterTenantState());
    } else {
      emit(RegisterOwnerState());
    }
  }

  Future<void> register() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _registerUseCase(
      RegisterUseCaseInput(
        username: _fireAuthUsername ?? _usernameController.text.trim(),
        email: _fireAuthEmail ?? _emailController.text.trim(),
        phoneNumber: _fireAuthPhoneNumber ?? _phoneNumberController.text.trim(),
        gender: _genderController.text.toLowerCase() == 'female'
            ? Gender.female
            : Gender.male,
        job: _jobController?.text.trim(),
        salary: _salaryController != null
            ? int.parse(_salaryController!.text.trim())
            : null,
        age: int.parse(_ageController.text.trim()),
        martialStatus: _martialStatusController?.text.trim(),
        userType: _registerType,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(
              ErrorState(
                failure: l,
                displayType: DisplayType.popUpDialog,
              ),
            );
          },
          (r) {
            emit(SuccessState('Registered Successfully'));
          },
        );
      },
    );
  }

  @override
  UserRole get getRegisterType => _registerType;

  @override
  TextEditingController get getAgeController => _ageController;

  @override
  TextEditingController get getEmailController => _emailController;

  @override
  TextEditingController get getGenderController => _genderController;

  @override
  TextEditingController get getJobController => _jobController!;

  @override
  TextEditingController get getMartialStatusController =>
      _martialStatusController!;

  @override
  TextEditingController get getPasswordController => _passwordController;

  @override
  TextEditingController get getPhoneNumberController => _phoneNumberController;

  @override
  TextEditingController get getSalaryController => _salaryController!;

  @override
  TextEditingController get getUsernameController => _usernameController;

  @override
  User? get getFireAuthUser => _fireAuthUser;

  @override
  String? get getFireAuthUsername => _fireAuthUsername;

  @override
  String? get getFireAuthEmail => _fireAuthEmail;

  @override
  String? get getFireAuthPhoneNumber => _fireAuthPhoneNumber;
}

abstract class RegisterViewModelInput {}

abstract class RegisterViewModelOutput {
  UserRole get getRegisterType;

  TextEditingController get getUsernameController;

  TextEditingController get getEmailController;

  TextEditingController get getPasswordController;

  TextEditingController get getPhoneNumberController;

  TextEditingController get getGenderController;

  TextEditingController get getJobController;

  TextEditingController get getSalaryController;

  TextEditingController get getAgeController;

  TextEditingController get getMartialStatusController;

  User? get getFireAuthUser;

  String? get getFireAuthUsername;

  String? get getFireAuthEmail;

  String? get getFireAuthPhoneNumber;
}
