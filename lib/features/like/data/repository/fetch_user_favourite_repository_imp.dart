import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/home/data/model/favourite_model.dart';
import 'package:tradpool/features/like/data/remote_data_source/get_user_favourites.dart';
import 'package:tradpool/features/like/domain/repository/fetch_user_favourite_repository.dart';

class FetchUserFavouriteRepositoryImp implements FetchUserFavouriteRepository{
  final FetchUserFavouriteRemoteData fetchUserFavouriteRemoteData;
  final NetworkInf networkInf;

  FetchUserFavouriteRepositoryImp(this.fetchUserFavouriteRemoteData, this.networkInf);

  @override
  Future<Either<Failure, FavouritesModel>> fetchUserRepository(String userId) async {
    if (await networkInf.isConnected) {
      try {
      final response =
          await fetchUserFavouriteRemoteData.fetchUserFavourite(userId);

      return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }

}