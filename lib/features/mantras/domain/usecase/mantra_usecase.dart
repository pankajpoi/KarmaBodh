import 'package:karmbodh/features/mantras/domain/repository/mantra_repository.dart';
import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';
class GetAllMantras{
  final MantraRepository repository;
  GetAllMantras({required this.repository});
  Future<List<Mantra>> call(){
    return repository.getAllMantras();
  }
}
class SearchMantras{
  final MantraRepository repository;
  SearchMantras({required this.repository});
  Future<List<Mantra>> call(){
    return repository.searchMantras('title');
  }
}