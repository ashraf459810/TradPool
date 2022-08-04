import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/usecases/usecase.dart';
import 'package:tradpool/features/sell/data/models/all_auctions_model.dart';
import 'package:tradpool/features/sell/domain/repositories/user_auctions_repositroy.dart';

class UserAuctionsUseCase
    implements UseCase<UserAuctionsModel, PagenationParams> {
  final UserAuctionsRepository userAuctionsRepository;

  UserAuctionsUseCase(this.userAuctionsRepository);

  @override
  Future<Either<Failure, UserAuctionsModel>> call(params) async {
    return await userAuctionsRepository.getAuctions(
        params.page, params.size, params.userToken);
  }
}

class PagenationParams {
  final int page;
  final int size;
  final String userToken;

  PagenationParams(this.page, this.size, this.userToken);
}
