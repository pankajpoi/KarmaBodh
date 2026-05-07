import 'package:karmbodh/features/item_identifier/domain/entities/item_entities.dart';

abstract class ItemRepository{
  Future<CameraEntity?> identifyitem();

}