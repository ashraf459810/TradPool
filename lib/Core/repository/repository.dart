import 'package:dartz/dartz.dart';

abstract class Repository {

  Future<Either<dynamic ,dynamic >>getrequest(Function([String response]) model, String url);

  Future<Either<dynamic ,dynamic >>postrequest(Function([String response]) model, String url, [body]);
  Future<Either<dynamic ,dynamic >>putrequest(Function([String response]) model, String url, [body]);
}