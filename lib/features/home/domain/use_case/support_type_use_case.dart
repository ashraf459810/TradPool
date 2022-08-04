import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/home/data/model/support_type_model.dart';
import 'package:tradpool/features/home/domain/repository/support_repositroy.dart';

abstract class SupportTypeUseCase {
  Future<Either<Failure,List<SupportTypeModel>>> supportTypeUseCase (String code);
}


class SupportTypeUseCaseImp implements SupportTypeUseCase {
  final SupportTypeRespository supportTypeRespository;

  SupportTypeUseCaseImp(this.supportTypeRespository);

  @override
  Future<Either<Failure, List<SupportTypeModel>> >supportTypeUseCase(String code) async {
    return await supportTypeRespository.supportRepository(code);
}}