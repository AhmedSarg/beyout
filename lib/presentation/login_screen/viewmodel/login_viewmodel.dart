import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/data/network/error_handler.dart';
import 'package:temp_house/domain/usecase/login_usecase.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/login_screen/viewmodel/states/login_states.dart';

import '../../../domain/usecase/sign_with_google_usecase.dart';
import '../../base/base_cubit.dart';

class LoginViewModel extends BaseCubit
    implements LoginViewModelInput, LoginViewModelOutput {
  static LoginViewModel get(BuildContext context) =>
      BlocProvider.of<LoginViewModel>(context);

  final LoginUseCase _loginUseCase;
  final SignWithGoogleUseCase _signWithGoogleUseCase;

  LoginViewModel(this._loginUseCase, this._signWithGoogleUseCase);

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
    await _loginUseCase(
      LoginUseCaseInput(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
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
            emit(SuccessState('Login Successfully'));
          },
        );
      },
    );
  }

  Future<void> signInWithGoogle() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _signWithGoogleUseCase(null).then(
      (value) {
        value.fold(
          (l) {
            if (l.code == DataSource.MISSING_DATA.getFailure().code) {
              emit(SocialLoginState());
            } else {
              emit(
                ErrorState(
                  failure: l,
                  displayType: DisplayType.popUpDialog,
                ),
              );
            }
          },
          (r) {
            emit(SuccessState('Login Successfully'));
          },
        );
      },
    );
  }
}

abstract class LoginViewModelInput {}

abstract class LoginViewModelOutput {
  TextEditingController get getEmailController;

  TextEditingController get getPasswordController;

  TextEditingController get getForgotPasswordEmailController;

  TextEditingController get getResetPasswordController;

  TextEditingController get getResetPasswordConfirmController;
}
