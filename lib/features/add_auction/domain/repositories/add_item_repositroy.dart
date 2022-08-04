import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/add_auction/data/models/add_file_response.dart';
import 'package:tradpool/features/add_auction/data/models/auction_body.dart';
import 'package:tradpool/features/add_auction/data/models/brands_for_sub_category.dart';
import 'package:tradpool/features/add_auction/data/models/calculate_response_model.dart';
import 'package:tradpool/features/add_auction/data/models/main_category.dart';
import 'package:tradpool/features/add_auction/data/models/sub_category.dart';

abstract class AddItemRepository {
  Future<Either<Failure, List<AddFileResponse>>> uploadFile(
      String tag, List<XFile> image);
  Future<Either<Failure, List<MainCategories>>> getMainCategory();
  Future<Either<Failure, List<SubCategories>>> getSubCategory(
      String maincategoryid);
  Future<Either<Failure, List<BrandsForSubCategoryModel>>>
      getBrandsForSubCategory(String subcategoryid);
  Future<Either<Failure, String>> addAuction(AuctionBody auctionBody , String imageId  , String address);
    Future<Either<Failure, CalculateResponseModel>> calculateAuction(AuctionBody auctionBody);
}
