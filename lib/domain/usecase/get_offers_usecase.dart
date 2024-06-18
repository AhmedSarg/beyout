import 'package:dartz/dartz.dart';
import 'package:temp_house/domain/models/domain.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetOffersUseCase
    extends BaseUseCase<GetOffersUseCaseInput, List<Future<OfferModel>>> {
  final Repository _repository;

  GetOffersUseCase(this._repository);

  @override
  Future<Either<Failure, List<Future<OfferModel>>>> call(
      GetOffersUseCaseInput input) async {
    return _repository.getOffers(ownerId: input.userId);
  }
}

class GetOffersUseCaseInput {
  final String userId;

  GetOffersUseCaseInput({
    required this.userId,
  });
}
