import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/presentation/provider/mantra_provider.dart';
import 'package:provider/provider.dart';
import 'package:karmbodh/features/mantras/presentation/page/mantra_detail_page.dart';
import 'package:karmbodh/features/mantras/presentation/page/mantra_list_page.dart';
import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({super.key});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final TextEditingController _controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textdata=Provider.of<MantraProvider>(context);
    return Scaffold(
      body: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText:"Enter the mantra",
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed:(){
              textdata.searchmantras(_controller.toString());
            },
          ),
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
      ),
    );

  }
}
class MantraCard extends StatelessWidget {
  final Mantra mantra;

  const MantraCard({super.key, required this.mantra});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MantraDetailPage(mantra: mantra),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🕉 Icon
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.deepOrange.shade100,
                child: const Icon(
                  Icons.self_improvement,
                  color: Colors.deepOrange,
                ),
              ),

              const SizedBox(width: 14),

              /// 📜 Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mantra.id,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      mantra.sanskrit,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

