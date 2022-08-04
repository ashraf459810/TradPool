import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/repository/repository.dart';

import '../network/http_interface.dart';


class RepositoryImp implements Repository {
  final HttpInterface httpHelper;

  RepositoryImp(this.httpHelper);

  @override
  Future<Either<dynamic, dynamic>> getrequest(
      Function([String response]) model, String url) async {
    try {
    var response = await httpHelper.getrequest(url);
    var decodeddata = model(response);
    return Right(decodeddata);
  }
  catch(e){

    return Left(e);
  }
  }

  @override
  Future<Either<dynamic, dynamic>> postrequest(
      Function([String response]) model, String url,
      [body]) async {
     try {
    var response = await httpHelper.postrequest(url, body);

    var decodeddata = model(response);

    return Right(decodeddata);
    }
    catch(e){

      return Left(e);
    }
  }
  
  @override
  Future<Either> putrequest(Function([String response]) model, String url, [body]) async {
     try {
    var response = await httpHelper.postrequest(url, body);

    var decodeddata = model(response);

    return Right(decodeddata);
    }
    catch(e){

      return Left(e);
    }
  }
}
