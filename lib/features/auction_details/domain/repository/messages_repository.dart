import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';

import 'package:tradpool/features/auction_details/data/model/messages_request_body.dart';

import '../../data/model/auction_details.dart';

abstract class MessagesRepository {
  Future<Either<Failure,List<Message>>> messagesRepository (MessageRequestBody messageRequestBody);
}
