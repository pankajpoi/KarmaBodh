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
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Provider.of<MantraProvider>(context, listen: false).fetchmantras();
  }

  @override
  Widget build(BuildContext context) {
    final mantraProvider = Provider.of<MantraProvider>(context);

    final data = mantraProvider.searchmantra.isEmpty
        ? mantraProvider.mantras
        : mantraProvider.searchmantra;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      appBar: AppBar(
        title: const Text(
          'Sacred Mantras',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepOrange.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            /// 🔍 Search Bar
            TextField(
              controller: _controller,
              onChanged: mantraProvider.searchmantras,
              decoration: InputDecoration(
                hintText: "Search mantra...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// 📿 Mantra List
            Expanded(
              child: data.isEmpty
                  ? const Center(
                child: Text(
                  "No mantras found",
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final mantra = data[index];
                  return MantraCard(mantra: mantra);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

