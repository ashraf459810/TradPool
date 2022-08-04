import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/like/domain/repository/add_to_favourite_repository.dart';

abstract class AddToFavouriteUseCase {
  Future <Either< Failure , void>> addToFavouriteUseCase ( String auctionId , String userId,String likeOrUnlike);
}





class AddtoFavouriteUseCaseImp implements AddToFavouriteUseCase{
  final AddToFavouriteRepository addToFavouriteRepository;

  AddtoFavouriteUseCaseImp(this.addToFavouriteRepository);

  @override
  Future<Either<Failure, void>> addToFavouriteUseCase(String auctionId, String userId,String likeOrUnlike) async{
   return await addToFavouriteRepository.addToFavourite(auctionId, userId,likeOrUnlike);
  }

  
}