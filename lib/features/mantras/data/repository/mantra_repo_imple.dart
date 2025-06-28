import 'package:karmbodh/features/mantras/data/data_source/Mantra_data_source.dart';
import 'package:karmbodh/features/mantras/data/model/mantra_model.dart';
import 'package:karmbodh/features/mantras/domain/repository/mantra_repository.dart';

class MantraRepositoryImpl extends MantraRepository{
  final MantraLocalDataSource localDataSource;
  MantraRepositoryImpl({required this.localDataSource});
  @override
  Future<List<MantraModel>> getAllMantras() async{
    final allmantras=await localDataSource.getAllData();
    return allmantras;

  }
  @override
  Future<List<MantraModel>> searchMantras(String query) async{
    final allmantras=await localDataSource.getAllData();
    return allmantras.where((mantra)=>mantra.title.toLowerCase().contains(query.toLowerCase())).toList();
  }




}