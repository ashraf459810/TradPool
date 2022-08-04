import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/add_auction/domain/repositories/get_tags_repository.dart';

abstract class GetTagsUseCase {
  Future<Either<Failure,List<String>> >getTagsUseCase (String categoryId);
}


class GetTagsUseCaseImp implements GetTagsUseCase{
  final GetTagsRepository getTagsRepository;

  GetTagsUseCaseImp(this.getTagsRepository);

  @override
  Future<Either<Failure, List<String>>> getTagsUseCase(String categoryId) async {
    return await getTagsRepository.tags(categoryId);
  }
}