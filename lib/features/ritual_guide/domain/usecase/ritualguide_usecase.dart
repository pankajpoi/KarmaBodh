import 'package:karmbodh/features/ritual_guide/data/data_source/ritualguide_datasource.dart';
import 'package:karmbodh/features/ritual_guide/domain/entity/ritualguide_entity.dart';
import 'package:karmbodh/features/ritual_guide/domain/repository/ritualguide_repository.dart';

class GetAnswer{
  final RitualguideRepository repository;
  GetAnswer({required this.repository});
  Future<Ritualguide> call(String){
    return repository.getAnswer(String);
  }
}


class ListenSpeech {
  final SpeechToTextService service;

  ListenSpeech(this.service);

  /// Initialize the speech
  Future<bool> init() async {
    return await service.init();
  }

  /// Start listening
  void call(Function(String) onResult) {
    service.startListening(onResult);
  }

  /// Stop listening
  void stop() {
    service.stopListening();
  }
}
