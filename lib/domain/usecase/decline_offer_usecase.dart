import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class DeclineOfferUseCase extends BaseUseCase<DeclineOfferUseCaseInput, void> {
  final Repository _repository;

  DeclineOfferUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(DeclineOfferUseCaseInput input) async {
    return _repository.declineOffer(offerId: input.offerId);
  }
}

class DeclineOfferUseCaseInput {
  final String offerId;

  DeclineOfferUseCaseInput({required this.offerId});
}
