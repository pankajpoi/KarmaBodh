import 'package:karmbodh/features/ritual_guide/data/data_source/ritualguide_datasource.dart';
import 'package:karmbodh/features/ritual_guide/data/model/ritualguide_model.dart';
import 'package:karmbodh/features/ritual_guide/domain/repository/ritualguide_repository.dart';

class RitualguideRepositoryImpl extends RitualguideRepository{
  final RagApiService ragapiservice;
  RitualguideRepositoryImpl({required this.ragapiservice});
  @override
  Future<RitualguideModel> getAnswer(String question) async{
    final answer=ragapiservice.askRag(question);
    return answer;
  }
}