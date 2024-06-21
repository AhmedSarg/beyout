import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/domain/services/notifications_controller.dart';
import 'package:temp_house/presentation/base/base_cubit.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

import '../../../app/sl.dart';
import '../../../domain/models/domain.dart';
import '../../../domain/usecase/get_offers_stream_usecase.dart';
import '../../../domain/usecase/get_offers_usecase.dart';

class AppViewModel extends BaseCubit
    implements AppViewModelInput, AppViewModelOutput {
  static AppViewModel get(context) => BlocProvider.of(context);

  final GetOffersStreamUseCase _getOffersStreamUseCase =
      sl<GetOffersStreamUseCase>();

  final GetOffersUseCase _getOffersUseCase = sl<GetOffersUseCase>();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  late final NotificationsController _notificationsController =
      NotificationsController(_navigatorKey);

  List<OfferModel> _offersList = [];

  @override
  void start() {
    _notificationsController.initialize();
  }

  fetchOffersStream() async {
    await fetchOffersList();
    _getOffersStreamUseCase(
      GetOffersStreamUseCaseInput(userId: DataIntent.getUser().uid),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
          },
          (r) async {
            r.listen(
              (futureOffer) {
                futureOffer.then(
                  (offer) {
                    bool exists = false;
                    for (OfferModel savedOffer in _offersList) {
                      if (savedOffer.id == offer.id) {
                        exists = true;
                      }
                    }
                    if (!exists) {
                      _notificationsController.sendNotification(
                        title: 'You just received a new offer!',
                        body:
                            '${offer.user.username} offered to rent ${offer.home.title}',
                        imageUrl: offer.home.imageUrl,
                      );
                      fetchOffersList();
                    }
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  fetchOffersList() async {
    await _getOffersUseCase(
            GetOffersUseCaseInput(userId: DataIntent.getUser().uid))
        .then(
      (value) {
        value.fold(
          (l) {
            debugPrint(l.message);
          },
          (r) async {
            _offersList = await r.wait;
          },
        );
      },
    );
  }

  @override
  GlobalKey<NavigatorState> get getNavigatorKey => _navigatorKey;
}

abstract class AppViewModelInput {}

abstract class AppViewModelOutput {
  GlobalKey<NavigatorState> get getNavigatorKey;
}
