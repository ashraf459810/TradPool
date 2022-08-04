import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import 'package:tradpool/features/add_auction/data/models/brands_for_sub_category.dart';
import 'package:tradpool/features/add_auction/domain/repositories/add_item_repositroy.dart';

class BrandsForSubCategoryUseCase {
  final AddItemRepository addItemRepository;

  BrandsForSubCategoryUseCase(this.addItemRepository);

  Future<Either<Failure, List<BrandsForSubCategoryModel>>> call(
      String params) async {
    return await addItemRepository.getBrandsForSubCategory(params);
  }
}
