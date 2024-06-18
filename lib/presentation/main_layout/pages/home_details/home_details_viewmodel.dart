import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/app/sl.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/domain/usecase/send_offer_usecase.dart';
import 'package:temp_house/presentation/base/base_cubit.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

class HomeDetailsViewModel extends BaseCubit
    implements HomeDetailsViewModelOutput {
  static HomeDetailsViewModel get(context) => BlocProvider.of(context);
  final SendOfferUseCase _sendOfferUseCase = sl<SendOfferUseCase>();

  late HomeModel _home;

  @override
  void start() {
    _home = DataIntent.popHome();
  }

  sendOffer(int price) {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    _sendOfferUseCase(
      SendOfferUseCaseInput(
        userId: DataIntent.getUser().uid,
        ownerId: _home.ownerId,
        homeId: _home.homeId,
        price: price,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
          },
          (r) {
            emit(
              SuccessState('Offer Sent Successfully\nWait for a Notification'),
            );
          },
        );
      },
    );
  }

  @override
  HomeModel get getHome => _home;
}

abstract class HomeDetailsViewModelOutput {
  HomeModel get getHome;
}
