import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';
import 'package:karmbodh/features/mantras/domain/usecase/mantra_usecase.dart';

class MantraProvider extends ChangeNotifier{
  final GetAllMantras getAllMantras;
  final SearchMantras searchMantras;
  MantraProvider({required this.getAllMantras,required this.searchMantras});
  List<Mantra> _mantras=[];
  List<Mantra> _searchmantra=[];
  List<Mantra> get mantras =>_mantras;
  List<Mantra> get searchmantra=>_searchmantra;
  Future<void> fetchmantras() async{
    _mantras=await getAllMantras();
    notifyListeners();
  }
  Future<void> searchmantras(String query) async{
    print(query);
    _searchmantra= await searchMantras(query);
    notifyListeners();
    }
}