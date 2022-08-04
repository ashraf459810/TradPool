import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/Core/usecases/usecase.dart';
import 'package:tradpool/features/add_auction/data/models/sub_category.dart';
import 'package:tradpool/features/add_auction/domain/repositories/add_item_repositroy.dart';

class GetSubCategoriesUseCase implements UseCase<List<SubCategories>, String> {
  final AddItemRepository addItemRepository;

  GetSubCategoriesUseCase(this.addItemRepository);

  @override
  Future<Either<Failure, List<SubCategories>>> call(String params) async {
    return await addItemRepository.getSubCategory(params);
  }
}
