import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/data/model/mantra_model.dart';


abstract class MantraLocalDataSource{
  Future<List<MantraModel>> getAllData();
}

class MantraLocalDataSourceImpl extends MantraLocalDataSource{
   static final List<Map<String,dynamic>> dummymantra=[
     {
       "id": "1",
       "title": "Gayatri Mantra",
       "content": "Om Bhur Bhuvah Swaha..."
     },
     {
       "id": "2",
       "title": "Maha Mrityunjaya Mantra",
       "content": "Om Tryambakam Yajamahe..."
     },
  ];
   @override
   Future<List<MantraModel>> getAllData() async{
     List<MantraModel> Mantras=dummymantra.map((json)=>MantraModel.fromJson(json)).toList();
     return Mantras;
   }
  
}