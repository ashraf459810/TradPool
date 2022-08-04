import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/home/data/model/faq_model.dart';
import 'package:tradpool/features/home/data/remote_data_source/get_faq_remote_data.dart';
import 'package:tradpool/features/home/domain/repository/faq_repository.dart';

class FAQRepositoryImp extends FAQRepository {
  final GetFAQRemoteData getFAQRemoteData;
  final NetworkInf networkInf;

  FAQRepositoryImp(this.getFAQRemoteData, this.networkInf);

  @override
  Future<Either<Failure,List< FaqModel>>> faq(String token) async {
      if (await networkInf.isConnected){

      try {
      var response = await getFAQRemoteData.getFAQ(token);
      return Right(response);

      }catch (e ){
        return Left(ServerFailure(e.error));
      }

    }
    else {
      return const Left( NetWorkFailure());
    }
  }
  
}