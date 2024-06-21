import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/domain/usecase/login_usecase.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import '../../base/base_cubit.dart';
import '../../resources/strings_manager.dart';

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

  void login() {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    _loginUseCase(
      LoginUseCaseInput(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    ).then(
          (value) {
        value.fold(
              (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
          },
              (r) {
            emit(SuccessState('Login successfully'));
          },
        );
      },
    );
  }



  Future<void> passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

}

abstract class LoginViewModelInput {
  TextEditingController get getEmailController;
  TextEditingController get getPasswordController;
  TextEditingController get getForgotPasswordEmailController;
  TextEditingController get getResetPasswordController;
  TextEditingController get getResetPasswordConfirmController;
}

abstract class LoginViewModelOutput {}
