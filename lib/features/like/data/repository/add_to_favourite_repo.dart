import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/like/data/remote_data_source/add_to_favourite.dart';
import 'package:tradpool/features/like/domain/repository/add_to_favourite_repository.dart';

class AddToFavouriteRepositoryImp implements AddToFavouriteRepository {
  final NetworkInf networkInf;
  final AddToFavouriteRemoteData addToFavouriteRemoteData;

  AddToFavouriteRepositoryImp(this.networkInf, this.addToFavouriteRemoteData);

  @override
  Future<Either<Failure, void>> addToFavourite(String auctionId, String userId,String likeOrUnlike) async{
    if (await networkInf.isConnected){

          try {
      final response =
          await addToFavouriteRemoteData.addToFavourite(auctionId,userId, likeOrUnlike);

      return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
     }


    }
  
