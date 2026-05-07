import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';

class MantraModel extends Mantra{
  MantraModel({
    required String id,
    required String sanskrit,
    required String translation,
    required List<dynamic> usage
}):super(id: id,sanskrit: sanskrit,translation: translation,usage: usage);

  factory MantraModel.fromJson(String id,Map<String,dynamic> json){
    return MantraModel(
        id:id,
        sanskrit: json['sanskrit'],
        translation: json['translation'],
        usage: json['usage']
    );


  }
  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'sanskrit':sanskrit,
      'translation':translation,
    };
  }
}