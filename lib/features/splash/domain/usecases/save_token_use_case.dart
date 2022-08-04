import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/splash/domain/repositories/save_token_repository.dart';

abstract class SaveTpkenUseCase {
  Future<Either<Failure, void>> saveTokenUseCase(String token, String fcmToken);
}

class SaveTokenUseCaseImp implements SaveTpkenUseCase {
  final SaveTokenRepository saveTokenRepository;

  SaveTokenUseCaseImp(this.saveTokenRepository);

  @override
  Future<Either<Failure, void>> saveTokenUseCase(
      String token, String fcmToken) async {
    return await saveTokenRepository.savetoken(token, fcmToken);
  }
}
