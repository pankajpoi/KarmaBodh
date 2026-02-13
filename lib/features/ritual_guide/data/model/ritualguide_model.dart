import 'package:karmbodh/features/ritual_guide/domain/entity/ritualguide_entity.dart';

class RitualguideModel extends Ritualguide{
  RitualguideModel({required String answer}):super(answer: answer);


  factory RitualguideModel.fromJson(Map<String,dynamic> json){
  return RitualguideModel(
      answer:json['answer']
      );
  }
  Map<String,dynamic> toJson(){
    return{
      'answer':answer
    };
  }
}