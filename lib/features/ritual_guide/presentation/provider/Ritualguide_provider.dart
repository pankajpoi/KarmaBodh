import 'package:flutter/cupertino.dart';
import 'package:karmbodh/features/ritual_guide/domain/entity/ritualguide_entity.dart';
import 'package:karmbodh/features/ritual_guide/domain/usecase/ritualguide_usecase.dart';

class RitualguideProvider extends ChangeNotifier{
  final TextEditingController controller=TextEditingController();

  final GetAnswer getanswer;
  RitualguideProvider({required this.getanswer});
  List<Map<String,String>> _messages=[];
  List<Map<String,String>> get messages=> _messages;
  bool isLoading=false;
  Future <void> getresult() async{
    final text=controller.text.trim();
    if(text.isEmpty) return;
    messages.add({"role":"user","text":text});
    isLoading=true;
    controller.clear();
    notifyListeners();
    final Ritualguide reply=await getanswer(text);
    messages.add({"role":"bot","text":reply.answer});
    isLoading=false;
    notifyListeners();


  }
}
class SpeechProvider extends ChangeNotifier {
  final ListenSpeech listenSpeechUseCase;

  SpeechProvider({required this.listenSpeechUseCase});

  String recognizedText = '';
  bool isListening = false;

  Future<void> init() async {
    await listenSpeechUseCase.init();
  }

  void startListening() {
    listenSpeechUseCase.call((text) {
      recognizedText = text;
      notifyListeners();
    });
    isListening = true;
    notifyListeners();
  }

  void stopListening() {
    listenSpeechUseCase.stop();
    isListening = false;
    notifyListeners();
  }

  void toggleListening() {
    if (!isListening) {
      startListening();
    } else {
      stopListening();
    }
  }
}

