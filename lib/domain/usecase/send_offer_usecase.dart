import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class SendOfferUseCase extends BaseUseCase<SendOfferUseCaseInput, void> {
  final Repository _repository;

  SendOfferUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(SendOfferUseCaseInput input) async {
    return _repository.sendOffer(
      userId: input.userId,
      ownerId: input.ownerId,
      homeId: input.homeId,
      price: input.price,
    );
  }
}

class SendOfferUseCaseInput {
  final String userId;
  final String ownerId;
  final String homeId;
  final int price;

  SendOfferUseCaseInput({
    required this.userId,
    required this.ownerId,
    required this.homeId,
    required this.price,
  });
}
