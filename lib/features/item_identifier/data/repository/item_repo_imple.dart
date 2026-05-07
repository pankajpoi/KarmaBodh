import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:karmbodh/features/item_identifier/domain/repositories/item_repositories.dart';
import 'package:karmbodh/features/item_identifier/data/data_source/Item_data.dart';
import 'package:karmbodh/features/item_identifier/domain/entities/item_entities.dart';
class ItemRepositoryImple extends ItemRepository{
  final picker=ImagePicker();
  File? image;
  @override
  Future<CameraEntity?> identifyitem() async {
    final pickedimage = await picker.pickImage(source: ImageSource.camera);
    if (pickedimage != null) {
      image = File(pickedimage.path);
      return CameraEntity(name: image!.path);
    }
    return null;
  }}