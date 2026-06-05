import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';

class MantraModel extends Mantra{
  MantraModel({
    required String id,
    required String sanskrit,
    required String translation,
    required List<dynamic> usage,
    String? audio
}):super(id: id,sanskrit: sanskrit,translation: translation,usage: usage, audio: audio);

  factory MantraModel.fromJson(String id,Map<String,dynamic> json){
    return MantraModel(
        id:id,
        sanskrit: json['sanskrit'],
        translation: json['translation'],
        audio: json['audio'],
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