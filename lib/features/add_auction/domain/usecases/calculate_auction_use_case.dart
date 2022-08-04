

import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/add_auction/data/models/calculate_response_model.dart';
import 'package:tradpool/features/add_auction/domain/repositories/add_item_repositroy.dart';

import '../../data/models/auction_body.dart';

abstract class CaluculateAuctionUseCase {
  Future<Either<Failure,CalculateResponseModel> >calculateUseCase (AuctionBody auctionBody);
}


class CaluculateAuctionUseCaseImp implements CaluculateAuctionUseCase{
  final AddItemRepository addItemRepository;

  CaluculateAuctionUseCaseImp(this.addItemRepository);
  
  @override
  Future<Either<Failure, CalculateResponseModel>> calculateUseCase(AuctionBody auctionBody) async{
  
  return await addItemRepository.calculateAuction(auctionBody);

  }
    
  
}