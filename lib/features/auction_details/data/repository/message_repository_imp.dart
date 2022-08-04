import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/auction_details/data/data_source/send_message_remote.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';

import 'package:tradpool/features/auction_details/data/model/messages_request_body.dart';
import 'package:tradpool/features/auction_details/domain/repository/messages_repository.dart';

class MessagesRepostiryImp implements MessagesRepository {
  final NetworkInf networkInf;
  final SendMessageRemoteData sendMessageRemoteData;

  MessagesRepostiryImp(this.networkInf, this.sendMessageRemoteData);

  @override
  Future<Either<Failure,List<Message> >> messagesRepository(MessageRequestBody messageRequestBody) async {
     if (await networkInf.isConnected) {
      try {
        final step = await sendMessageRemoteData.sendMessage(messageRequestBody);

        return Right(step);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}