import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/home/data/model/support_type_model.dart';

abstract class SupportTypeRespository {
  Future<Either<Failure,List<SupportTypeModel >>> supportRepository (String code);
}