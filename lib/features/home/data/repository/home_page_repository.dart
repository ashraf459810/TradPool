import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/home/data/model/home_page_model.dart';
import 'package:tradpool/features/home/data/remote_data_source/home_page_remote_data.dart';
import 'package:tradpool/features/home/domain/repository/home_page_repostiroy.dart';


class HomePageRepositoryImp implements HomePageRepository {
  final HomePageRemoteData homePageRemoteData;
  final NetworkInf networkInf ;

  HomePageRepositoryImp(this.homePageRemoteData, this.networkInf);

  @override
  Future<Either<Failure, HomePageModel>> gethomePageRepo(String clientId) async {
     if (await networkInf.isConnected){

            //  try {
      final response =
          await homePageRemoteData.homePageRemoteData(clientId);

      return Right(response);
      // } catch (e) {
      //   return Left(ServerFailure(e.error));
      // }
    } else {
      return const Left(NetWorkFailure());
    }
     }
  
}