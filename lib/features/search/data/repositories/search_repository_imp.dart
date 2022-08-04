import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/search/data/datasources/search_remote_data.dart';
import 'package:tradpool/features/search/data/models/search_response_model.dart';
import 'package:tradpool/features/search/data/models/search_request_model.dart';
import 'package:tradpool/features/search/domain/repositories/search_repository.dart';

class SearchRepostoryImp implements SearchRepository {
  final NetworkInf networkInf;
  final SearchRemoteDate searchRemoteDate;

  SearchRepostoryImp(this.networkInf, this.searchRemoteDate);

  @override
  Future<Either<Failure, SearchResponseModel>> searchRepo(SearchRequestModel searchRequestModel) async {
    
      if (await networkInf.isConnected) {
      try {
        final response = await searchRemoteDate.search(searchRequestModel);

        return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}