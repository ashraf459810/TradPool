import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/search/data/models/search_request_model.dart';
import 'package:tradpool/features/search/data/models/search_response_model.dart';
import 'package:tradpool/features/search/domain/repositories/search_repository.dart';

abstract class SearchUseCase {
  Future<Either<Failure,SearchResponseModel> >searchUseCase (SearchRequestModel searchRequestModel);
}





class SearchUseCaseImp implements SearchUseCase {
  final SearchRepository searchRepository;

  SearchUseCaseImp(this.searchRepository);

  @override
  Future<Either<Failure, SearchResponseModel>> searchUseCase(SearchRequestModel searchRequestModel) async {
    return await searchRepository.searchRepo(searchRequestModel);
  }
}