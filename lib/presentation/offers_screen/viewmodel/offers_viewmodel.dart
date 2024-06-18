import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/app/sl.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/domain/usecase/accept_offer_usecase.dart';
import 'package:temp_house/domain/usecase/decline_offer_usecase.dart';
import 'package:temp_house/domain/usecase/get_offers_usecase.dart';
import 'package:temp_house/presentation/base/base_cubit.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'package:temp_house/presentation/offers_screen/states/offers_states.dart';

class OffersViewModel extends BaseCubit
    implements OffersViewModelInput, OffersViewModelOutput {
  static OffersViewModel get(context) => BlocProvider.of(context);

  final GetOffersUseCase _getOffersUseCase = sl<GetOffersUseCase>();
  final AcceptOfferUseCase _acceptOffersUseCase = sl<AcceptOfferUseCase>();
  final DeclineOfferUseCase _declineOffersUseCase = sl<DeclineOfferUseCase>();

  late List<Future<OfferModel>> _offers;

  @override
  void start() {
    _fetchOffers();
  }

  _fetchOffers() async {
    emit(LoadingState());
    await _getOffersUseCase(
      GetOffersUseCaseInput(userId: DataIntent.getUser().uid),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l));
          },
          (r) {
            _offers = r;
            if (_offers.isEmpty) {
              emit(EmptyState());
            } else {
              emit(ContentState());
            }
          },
        );
      },
    );
  }

  acceptOffer({
    required String offerId,
    required String userId,
    required String homeId,
  }) async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _acceptOffersUseCase(
      AcceptOfferUseCaseInput(
        offerId: offerId,
        userId: userId,
        homeId: homeId,
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
            _fetchOffers();
            emit(OfferAcceptedState());
            emit(ContentState());
          },
        );
      },
    );
  }

  declineOffer({required String offerId}) async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _declineOffersUseCase(
      DeclineOfferUseCaseInput(offerId: offerId),
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
            _fetchOffers();
            emit(OfferDeclinedState());
            emit(ContentState());
          },
        );
      },
    );
  }

  @override
  List<Future<OfferModel>> get getOffers => _offers;
}

abstract class OffersViewModelInput {}

abstract class OffersViewModelOutput {
  List<Future<OfferModel>> get getOffers;
}
