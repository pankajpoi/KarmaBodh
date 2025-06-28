import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';
import 'package:karmbodh/features/mantras/domain/usecase/mantra_usecase.dart';
import 'package:karmbodh/features/mantras/domain/repository/mantra_repository.dart';
class MantraListPage extends StatefulWidget {
  const MantraListPage({super.key});

  @override
  State<MantraListPage> createState() => _MantraListPageState();
}

class _MantraListPageState extends State<MantraListPage> {
  final List<Mantra> listofmantra=[];
  void initState(){
    super.initState();
  }
  void getlistmantra() async{

    final usecase= GetAllMantras(repository:);
    final list=await usecase();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mantras'),
      ),
      body: ListView.builder(
          itemBuilder: (context,index){
            return ListTile(
              title:Text("mantras"),
            );
          },
          itemCount: 20,

      ),
    );
  }
}
