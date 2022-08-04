import 'package:image_picker/image_picker.dart';
import 'package:tradpool/core/error/exceptions.dart';
import 'package:tradpool/Core/network/network_info.dart';

import 'package:tradpool/features/add_auction/data/datasources/add_item_remote_data.dart';
import 'package:tradpool/features/add_auction/data/models/add_file_response.dart';
import 'package:tradpool/features/add_auction/data/models/auction_body.dart';
import 'package:tradpool/features/add_auction/data/models/brands_for_sub_category.dart';
import 'package:tradpool/features/add_auction/data/models/calculate_response_model.dart';
import 'package:tradpool/features/add_auction/data/models/main_category.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/features/add_auction/data/models/sub_category.dart';
import 'package:tradpool/features/add_auction/domain/repositories/add_item_repositroy.dart';

typedef MainCategoryResponse = Future<List<MainCategories>> Function();
typedef SubCategoryResponse = Future<List<SubCategories>> Function();
typedef GetBrandsForSub = Future<List<BrandsForSubCategoryModel>> Function();
typedef AddAuction = Future<String> Function();

class AddItemRepositoryImp implements AddItemRepository {
  final AddItemRemoteData addItemRemoteData;
  final NetworkInf networkInf;

  AddItemRepositoryImp(this.addItemRemoteData, this.networkInf);
  @override
  Future<Either<Failure, List<MainCategories>>> getMainCategory() async {
    return await getTheMainCategory(() {
      return addItemRemoteData.getCategory();
    });
  }

  Future<Either<Failure, List<MainCategories>>> getTheMainCategory(
    MainCategoryResponse mainCategoryResponse,
  ) async {
    if (await networkInf.isConnected) {
      try {
        final response = await mainCategoryResponse();
  
        return Right(response);
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }

  @override
  Future<Either<Failure, List<SubCategories>>> getSubCategory(
      String maincategoryid) async {
    return await getThesubCategory(() {
      return addItemRemoteData.getSubCategory(maincategoryid);
    });
  }

  Future<Either<Failure, List<SubCategories>>> getThesubCategory(
    SubCategoryResponse subCategoryResponse,
  ) async {
    {
      if (await networkInf.isConnected) {
        try {
          final response = await subCategoryResponse();

          return Right(response);
        } on ServerException {
          var error = ServerException().error;
          return Left(ServerFailure(error));
        } catch (e) {
          rethrow;
        }
      } else {
        return const Left(NetWorkFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> addAuction(AuctionBody auctionBody, String imageId , String address) async {
    return await addTheAuction(() {
      return addItemRemoteData.addAuction(auctionBody,imageId,address);
    });
  }

  Future<Either<Failure, String>> addTheAuction(
    AddAuction addAuction,
  ) async {
    if (await networkInf.isConnected) {
      try {
        final response = await addAuction();

        return Right(response);
      } on ServerException {
        return Left(ServerFailure(ServerException().error));
      } catch (e) {
        rethrow;
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }

  @override
  Future<Either<Failure, List<BrandsForSubCategoryModel>>>
      getBrandsForSubCategory(String subcategoryid) async {
    return await getTheBrands(() {
      return addItemRemoteData.getbrands(subcategoryid);
    });
  }

  Future<Either<Failure, List<BrandsForSubCategoryModel>>> getTheBrands(
    GetBrandsForSub getBrandsForSub,
  ) async {
    if (await networkInf.isConnected) {
      try {
        final response = await getBrandsForSub();

        return Right(response);
      
      } catch (e) {
        return Left(ServerFailure(ServerException().error));
      }
    } else {
      return Left(ServerFailure(ServerException().error));
    }
  }

  @override
  Future<Either<Failure, List<AddFileResponse>>> uploadFile(
      String tag, List<XFile> image) async {
    if (await networkInf.isConnected) {
      try {
        final response =
            await addItemRemoteData.uploadFile(tag: tag, image: image);

        return Right(response);
      } on ServerException {
        return Left(ServerFailure(ServerException().error));
      } catch (e) {
        rethrow;
      }
    } else {
      return Left(ServerFailure(ServerException().error));
    }
  }

  @override
  Future<Either<Failure, CalculateResponseModel>> calculateAuction(AuctionBody auctionBody) async {
    if (await networkInf.isConnected) {
      try {
        final response =
            await addItemRemoteData.calculateAuction(auctionBody);

        return Right(response);
      } on ServerException {
        return Left(ServerFailure(ServerException().error));
      } catch (e) {
        rethrow;
      }
    } else {
      return Left(ServerFailure(ServerException().error));
    }
  }
}
