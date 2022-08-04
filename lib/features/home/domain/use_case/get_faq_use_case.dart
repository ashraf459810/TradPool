import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/home/data/model/faq_model.dart';
import 'package:tradpool/features/home/domain/repository/faq_repository.dart';

abstract class FAQUseCase {
  Future<Either<Failure,List<FaqModel>>> faqUseCase ( String token);
}


class FAQUseCaseImp implements FAQUseCase {
  final FAQRepository faqrEpository;

  FAQUseCaseImp(this.faqrEpository);

  @override
  Future<Either<Failure, List<FaqModel>>> faqUseCase(String token) async {
  return await faqrEpository.faq(token);
  }
}