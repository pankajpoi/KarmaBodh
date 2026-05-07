import 'package:karmbodh/features/ritual_guide/domain/entity/ritualguide_entity.dart';

abstract class RitualguideRepository{
  Future<Ritualguide> getAnswer(String question);
}
abstract class SpeechtoTextRepository{
  Future<bool> init();
  void startListening(Function(String) onResult);
  void stopListening();
}