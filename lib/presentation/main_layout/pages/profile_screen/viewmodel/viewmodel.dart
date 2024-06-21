import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/main_layout/pages/profile_screen/viewmodel/stats.dart';

import '../../../../../domain/usecase/logout_usecase.dart';
import '../../../../base/base_cubit.dart';
import '../../../../base/base_states.dart';


class ProfileViewModel extends BaseCubit
    implements ProfileViewModelInput, ProfileViewModelOutput {
  static ProfileViewModel get(context) => BlocProvider.of(context);

  final LogOutUseCase _logoutUseCase;

  ProfileViewModel(this._logoutUseCase);



  Future<void> logout() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _logoutUseCase.call(null).then(
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
            emit(LogoutState());
          },
        );
      },
    );
  }

  @override
  void start() {

  }


}

abstract class ProfileViewModelInput {}

abstract class ProfileViewModelOutput {

}
