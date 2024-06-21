import 'package:dartz/dartz.dart';
import 'package:temp_house/domain/models/domain.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetOffersStreamUseCase extends BaseUseCase<GetOffersStreamUseCaseInput,
    Stream<Future<OfferModel>>> {
  final Repository _repository;

  GetOffersStreamUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<Future<OfferModel>>>> call(
      GetOffersStreamUseCaseInput input) async {
    return _repository.getOffersStream(userId: input.userId);
  }
}

class GetOffersStreamUseCaseInput {
  final String userId;

  GetOffersStreamUseCaseInput({
    required this.userId,
  });
}
