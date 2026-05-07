import 'package:karmbodh/features/item_identifier/domain/entities/item_entities.dart';
import 'package:karmbodh/features/item_identifier/domain/repositories/item_repositories.dart';
class IdentifyItem{
  final ItemRepository repository;
  IdentifyItem({required this.repository});
  Future<CameraEntity?> call(){
    return repository.identifyitem();
  }
}