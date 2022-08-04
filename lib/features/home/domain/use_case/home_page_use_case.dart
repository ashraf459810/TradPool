import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/home/data/model/home_page_model.dart';
import 'package:tradpool/features/home/domain/repository/home_page_repostiroy.dart';

abstract class HomePageUseCase {
  Future<Either<Failure,HomePageModel>> homePageUseCase ( String clientId);
}



class HomePageUseCaseImp implements HomePageUseCase {
  final HomePageRepository homePageRepository;
  final NetworkInf networkInf ;

  HomePageUseCaseImp(this.homePageRepository, this.networkInf);

  @override
  Future<Either<Failure, HomePageModel>> homePageUseCase(String clientId) async {
    return await homePageRepository.gethomePageRepo(clientId);
  }
}