
import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/buy/data/datasources/paid_action_remote_data.dart';
import 'package:tradpool/features/buy/data/models/buy_model.dart';
import 'package:tradpool/features/buy/domain/repositories/paid_auctions_repository.dart';

class PaidAuctionRepositryImp implements PaidAuctionsRepository{
  final NetworkInf networkInf;
  final PaidAuctionsRemoteData paidAuctionsRemoteData;

  PaidAuctionRepositryImp(this.networkInf, this.paidAuctionsRemoteData);

  @override
  Future<Either<Failure,List< BuyAuctionModel>>> getPaidAuctions(String userId) async {
    if (await networkInf.isConnected){

           try {
      final response =
          await paidAuctionsRemoteData.getPaidAuctions(userId);

      return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }

    }
  }
