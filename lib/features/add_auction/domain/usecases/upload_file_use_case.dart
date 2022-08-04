import 'package:image_picker/image_picker.dart';

import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import 'package:tradpool/features/add_auction/data/models/add_file_response.dart';
import 'package:tradpool/features/add_auction/domain/repositories/add_item_repositroy.dart';

class UploadFileUseCase {
  final AddItemRepository addItemRepository;

  UploadFileUseCase(this.addItemRepository);

  Future<Either<Failure, List<AddFileResponse>>> uploadimage(
      String tag, List<XFile> list) async {
    return await addItemRepository.uploadFile(tag, list);
  }
}
