import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/home/data/model/home_page_model.dart';

abstract class HomePageRepository {
  Future <Either<Failure, HomePageModel>> gethomePageRepo(String clientId);
}

