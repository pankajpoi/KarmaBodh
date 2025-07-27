import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';
class MantraDetailPage extends StatelessWidget {
  final Mantra mantra;
  MantraDetailPage({required this.mantra});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mantras"),
      ),
      body: Text(mantra.desc),

    );
  }
}
