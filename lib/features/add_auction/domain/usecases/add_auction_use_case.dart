import 'package:tradpool/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:tradpool/features/add_auction/data/models/auction_body.dart';

import 'package:tradpool/features/add_auction/domain/repositories/add_item_repositroy.dart';




abstract class AddAuctionUseCasee {
  Future<Either<Failure , String >> addAuctionUseCase(AuctionBody auctionBody , String imageId , String address);

}

class AddAuctionUseCase implements AddAuctionUseCasee {
  final AddItemRepository addItemRepository;

  AddAuctionUseCase(this.addItemRepository);
  
  @override
  Future<Either<Failure, String>> addAuctionUseCase(AuctionBody auctionBody, String imageId, String address) async {
    return await addItemRepository.addAuction(auctionBody, imageId, address);
  }
  


}