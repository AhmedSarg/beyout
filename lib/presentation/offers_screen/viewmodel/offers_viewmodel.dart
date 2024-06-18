import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/app/sl.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/domain/usecase/get_offers_usecase.dart';
import 'package:temp_house/presentation/base/base_cubit.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

class OffersViewModel extends BaseCubit
    implements OffersViewModelInput, OffersViewModelOutput {
  static OffersViewModel get(context) => BlocProvider.of(context);

  final GetOffersUseCase _getOffersUseCase = sl<GetOffersUseCase>();

  late final List<OfferModel> _offers;

  @override
  void start() {
    _fetchOffers();
  }

  _fetchOffers() {
    _getOffersUseCase(
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

  @override
  List<OfferModel> get getOffers => _offers;
}

abstract class OffersViewModelInput {}

abstract class OffersViewModelOutput {
  List<OfferModel> get getOffers;
}
