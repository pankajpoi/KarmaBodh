
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:karmbodh/features/ritual_guide/data/model/ritualguide_model.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RagApiService {
  final String baseUrl = "http://10.0.2.2:8000";

  Future<RitualguideModel> askRag(String query) async {
    final url = Uri.parse("$baseUrl/rag/query");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"query": query}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final RitualguideModel result=RitualguideModel.fromJson(data);
      return result;
    } else {
      throw Exception("Failed to get response: ${response.body}");
    }
  }
}
class SpeechToTextService {
  final SpeechToText _speech = SpeechToText();


  Future<bool> init() async {
    bool isInitialized= await _speech.initialize();
    print(isInitialized);
    return isInitialized;
  }

  void startListening(Function(String) onResult) {
    _speech.listen(
      localeId: 'ne_NP', // use 'ne_NP' for Nepali
      onResult: (result) {
        onResult(result.recognizedWords);
      },
    );
  }

  void stopListening() {
    _speech.stop();
  }

  bool get isListening => _speech.isListening;
}