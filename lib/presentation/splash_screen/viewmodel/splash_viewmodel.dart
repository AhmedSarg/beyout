import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/sl.dart';
import '../../../domain/usecase/get_current_user_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../states/splash_states.dart';

class SplashViewModel extends BaseCubit
    implements SplashViewModelInput, SplashViewModelOutput {
  static SplashViewModel get(context) => BlocProvider.of(context);

  final GetCurrentUserUseCase _getCurrentUserUseCase =
      sl<GetCurrentUserUseCase>();

  @override
  void start() {
    print('splash started');
  }

  Future<void> getCurrentUser() async {
    await _getCurrentUserUseCase(null).then(
      (value) {
        value.fold(
          (l) {
            emit(
              ErrorState(
                failure: l,
                retry: () async {
                  emit(LoadingState());
                  await getCurrentUser();
                },
              ),
            );
          },
          (r) {
            print(r);
            if (r == null) {
              emit(UserNotSignedState());
            } else {
              emit(UserSignedState());
            }
          },
        );
      },
    );
  }
}

abstract class SplashViewModelInput {}

abstract class SplashViewModelOutput {}
