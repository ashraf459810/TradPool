import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';

import 'package:tradpool/features/auction_details/data/model/messages_request_body.dart';
import 'package:tradpool/features/auction_details/domain/repository/messages_repository.dart';

import '../../data/model/auction_details.dart';

abstract class SendMessageUseCase {
  Future<Either<Failure,List<Message>>> sendMessageUseCase ( MessageRequestBody messageRequestBody);
}


class SendMessageUseCaseImp implements SendMessageUseCase {
  final MessagesRepository messagesRepository;

  SendMessageUseCaseImp(this.messagesRepository);

  @override
  Future<Either<Failure, List<Message>>> sendMessageUseCase(MessageRequestBody messageRequestBody) async {
    return await messagesRepository.messagesRepository(messageRequestBody);
  }
}