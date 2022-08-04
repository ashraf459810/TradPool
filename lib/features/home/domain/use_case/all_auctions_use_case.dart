import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/home/data/model/all_auctions_model.dart';

import 'package:dartz/dartz.dart';
import 'package:tradpool/features/home/domain/repository/all_auctions_repository.dart';

class AllAuctionsUseCase implements AllAuctionsRepository {
  final AllAuctionsRepository allAuctionsRepository;

  AllAuctionsUseCase(this.allAuctionsRepository);
  @override
  Future<Either<Failure, AllAuctionsModel>> getAllAuctions(
      int page, int size) async {
    return await allAuctionsRepository.getAllAuctions(page, size);
  }
}
