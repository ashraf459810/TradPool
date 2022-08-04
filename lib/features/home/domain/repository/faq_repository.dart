import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/home/data/model/faq_model.dart';

abstract class FAQRepository {
  Future<Either<Failure,List<FaqModel >>> faq (String token);

}