
import 'dart:developer';

import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';

import 'package:tradpool/features/add_auction/data/datasources/get_tags_remote_data.dart';
import 'package:tradpool/features/add_auction/domain/repositories/get_tags_repository.dart';


class GetTagsRepositoryImp implements GetTagsRepository {
  final GetTagsRemoteData getTagsRmoteData;
  final NetworkInf networkInf;

  GetTagsRepositoryImp(this.getTagsRmoteData, this.networkInf);

  @override
  Future<Either<Failure, List<String>>> tags(String categoryId) async {
          if (await networkInf.isConnected) {
      try {
        final response = await getTagsRmoteData.getTags(categoryId);
      log(response);
        return Right(response);
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetWorkFailure());
    
  }
  }





}