import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/Core/usecases/usecase.dart';
import 'package:tradpool/features/verfication/data/models/verfication_model.dart';
import 'package:tradpool/features/verfication/domain/repositories/verfication_repository.dart';

class VerficationUseCase
    implements UseCase<VerificationResponse, MobileAndCode> {
  final VerficationRepository verficationRepository;

  VerficationUseCase(this.verficationRepository);
  @override
  Future<Either<Failure, VerificationResponse>> call(
      MobileAndCode mobileAndCode) async {
    return await verficationRepository.checkcode(
        mobileAndCode.mobile, mobileAndCode.code);
  }
}

class MobileAndCode {
  final String mobile;
  final String code;

  MobileAndCode({this.mobile, this.code});
}
