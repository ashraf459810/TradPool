import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';

abstract class GetTagsRepository {
  Future<Either<Failure,List<String>>> tags(String categoryId);
}

