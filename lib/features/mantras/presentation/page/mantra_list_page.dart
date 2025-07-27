import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';
import 'package:karmbodh/features/mantras/domain/usecase/mantra_usecase.dart';
import 'package:karmbodh/features/mantras/domain/repository/mantra_repository.dart';
import 'package:karmbodh/features/mantras/presentation/page/mantra_detail_page.dart';
import 'package:karmbodh/features/mantras/presentation/provider/mantra_provider.dart';
import 'package:karmbodh/features/mantras/presentation/widgets/mantra_tile.dart';
import 'package:provider/provider.dart';

class MantraListPage extends StatefulWidget {
  const MantraListPage({super.key});

  @override
  State<MantraListPage> createState() => _MantraListPageState();
}

class _MantraListPageState extends State<MantraListPage> {
  final TextEditingController _controller=TextEditingController();
  void initState() {
    super.initState();
    getdata();
  }
  Future<void> getdata()  async{
    await Provider.of<MantraProvider>(context, listen: false).fetchmantras();

  }
  @override
  Widget build(BuildContext context) {
    final mantradata = Provider.of<MantraProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Mantras')),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
                labelText:"Enter the mantra",
                suffixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
            onChanged: (text){
              mantradata.searchmantras(text);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount:mantradata.searchmantra.isEmpty?mantradata.mantras.length:mantradata.searchmantra.length,
              itemBuilder: (context, index) {
                final data=mantradata.searchmantra.isEmpty?mantradata.mantras:mantradata.searchmantra;
                return ListTile(
                  leading: Text("${data[index].id}"),
                  title: Text("${data[index].title}"),
                  subtitle: Text("${data[index].desc}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => MantraDetailPage(mantra: data[index]),
                      ),
                    );
                  },
                );
              },

            ),
          ),
        ],
      ),
    );
  }
}
