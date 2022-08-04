import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/settings/data/model/winned_auctions_model.dart';
import 'package:tradpool/features/settings/domain/repository/winned_auctions_repository.dart';

abstract class WinnedAuctionsUseCase {
  Future<Either<Failure,WinnedAuctionsModel>> winnedAuctionsUseCase ( String userId , String page , String size);
}
class WinnedAuctionsUseCaseImp implements WinnedAuctionsUseCase {
final WinnedAuctionsRepository winnedAuctionsRepository;

  WinnedAuctionsUseCaseImp(this.winnedAuctionsRepository);

  @override
  Future<Either<Failure, WinnedAuctionsModel>> winnedAuctionsUseCase(String userId, String page, String size) async {
 return await winnedAuctionsRepository.winnedRepository(userId, page, size);
  }
}