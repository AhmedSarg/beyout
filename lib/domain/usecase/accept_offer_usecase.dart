import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AcceptOfferUseCase extends BaseUseCase<AcceptOfferUseCaseInput, void> {
  final Repository _repository;

  AcceptOfferUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(AcceptOfferUseCaseInput input) async {
    return _repository.acceptOffer(
      offerId: input.offerId,
      userId: input.userId,
      homeId: input.homeId,
    );
  }
}

class AcceptOfferUseCaseInput {
  final String offerId;
  final String userId;
  final String homeId;

  AcceptOfferUseCaseInput({
    required this.offerId,
    required this.userId,
    required this.homeId,
  });
}
