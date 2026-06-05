import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/data/model/mantra_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


abstract class MantraLocalDataSource{
  Future<List<MantraModel>> getAllData();
}

class MantraLocalDataSourceImpl extends MantraLocalDataSource{

   @override
   Future<List<MantraModel>> getAllData() async{
     final jsonString =
     await rootBundle.loadString('assets/data/mantra.json');


     final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

     return jsonMap.entries
         .map((e) => MantraModel.fromJson(e.key, e.value))
         .toList();
   }
  
}