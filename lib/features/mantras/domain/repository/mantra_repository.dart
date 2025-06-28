import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';

abstract class MantraRepository{
  Future<List<Mantra>> getAllMantras();
  Future<List<Mantra>> searchMantras(String title);
}