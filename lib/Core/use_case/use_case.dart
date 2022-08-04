import 'package:dartz/dartz.dart';


import '../repository/repository.dart';

abstract class UseCasee {
  Future<Either<dynamic, dynamic>> getUsecase(
      String url, Function([String response]) model);
  Future<Either<dynamic, dynamic>> postUsecase(
      String url, Function([String response]) model, body);

        Future<Either<dynamic, dynamic>> putUsecase(
      String url, Function([String response]) model, body);
}

class UseCaseImp implements UseCasee {
  final Repository repository;
  UseCaseImp(this.repository);

  @override
  Future<Either<dynamic, dynamic>> getUsecase(
      String url, Function([String response]) model) async {
    return await repository.getrequest(model, url);
  }

  @override
  Future<Either<dynamic, dynamic>> postUsecase(
      String url, Function([String response]) model, body) async {
    return await repository.postrequest(model, url, body);
  }
  
  @override
  Future<Either> putUsecase(String url, Function([String response]) model, body) async {
     return await repository.postrequest(model, url, body);
  }
}
