import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/search/data/models/search_request_model.dart';
import 'package:tradpool/features/search/data/models/search_response_model.dart';

abstract class SearchRepository {
  Future <Either<Failure,SearchResponseModel>> searchRepo (SearchRequestModel searchRequestModel);}

  