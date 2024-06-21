import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/domain/usecase/login_usecase.dart';
import 'package:temp_house/presentation/base/base_states.dart';

// import '../../../domain/usecase/sign_with_google_usecase.dart';
import '../../base/base_cubit.dart';

class LoginViewModel extends BaseCubit
    implements LoginViewModelInput, LoginViewModelOutput {
  static LoginViewModel get(BuildContext context) =>
      BlocProvider.of<LoginViewModel>(context);

  final LoginUseCase _loginUseCase;
  // final SignWithGoogleUseCase _signWithGoogleUseCase;

  LoginViewModel(this._loginUseCase /*, this._signWithGoogleUseCase*/);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _forgotPasswordEmailController =
      TextEditingController();
  final TextEditingController _resetPasswordController =
      TextEditingController();
  final TextEditingController _resetPasswordConfirmController =
      TextEditingController();

  @override
  void start() {}

  @override
  TextEditingController get getEmailController => _emailController;

  @override
  TextEditingController get getPasswordController => _passwordController;

  @override
  TextEditingController get getForgotPasswordEmailController =>
      _forgotPasswordEmailController;

  @override
  TextEditingController get getResetPasswordController =>
      _resetPasswordController;

  @override
  TextEditingController get getResetPasswordConfirmController =>
      _resetPasswordConfirmController;

  Future<void> login() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    final result = await _loginUseCase(LoginUseCaseInput(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    ));
    result.fold(
      (failure) => emit(
          ErrorState(failure: failure, displayType: DisplayType.popUpDialog)),
      (user) => emit(SuccessState('Login Successfully')),
    );
  }

  // @override
  // Future<void> signInWithGoogle() async {
  //   emit(LoadingState(displayType: DisplayType.popUpDialog));
  //   final result = await _signWithGoogleUseCase(SignWithGoogleUseCaseInput());
  //   result.fold(
  //         (failure) => emit(ErrorState(failure: failure, displayType: DisplayType.popUpDialog)),
  //         (user) => emit(SuccessState('Login Successfully')),
  //   );
  // }
}

abstract class LoginViewModelInput {
  TextEditingController get getEmailController;
  TextEditingController get getPasswordController;
  TextEditingController get getForgotPasswordEmailController;
  TextEditingController get getResetPasswordController;
  TextEditingController get getResetPasswordConfirmController;
}

abstract class LoginViewModelOutput {}
