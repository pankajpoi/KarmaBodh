import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';

class MantraModel extends Mantra{
  MantraModel({
    required String id,
    required String title,
    required String desc
}):super(id: id,title: title,desc: desc);

  factory MantraModel.fromJson(Map<String,dynamic> json){
    return MantraModel(
        id: json['id'],
        title: json['title'],
        desc: json['desc']);
  }
  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'title':title,
      'desc':desc
    };
  }
}