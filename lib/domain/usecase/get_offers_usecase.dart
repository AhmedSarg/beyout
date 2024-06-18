import 'package:dartz/dartz.dart';
import 'package:temp_house/domain/models/domain.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetOffersUseCase extends BaseUseCase<void, List<OfferModel>> {
  final Repository _repository;

  GetOffersUseCase(this._repository);

  @override
  Future<Either<Failure, List<OfferModel>>> call(input) async {
    throw UnimplementedError();
  }
}

class GetOffersUseCaseInput {}
