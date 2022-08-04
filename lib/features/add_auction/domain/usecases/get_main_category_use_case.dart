import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import 'package:tradpool/features/add_auction/data/models/main_category.dart';
import 'package:tradpool/features/add_auction/domain/repositories/add_item_repositroy.dart';

class GetMainCategoriesUseCase {
  final AddItemRepository addItemRepository;

  GetMainCategoriesUseCase(this.addItemRepository);

  Future<Either<Failure, List<MainCategories>>> call() async {
    return await addItemRepository.getMainCategory();
  }
}
