import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';
class MantraDetailPage extends StatelessWidget {
  final Mantra mantra;

  const MantraDetailPage({super.key, required this.mantra});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      appBar: AppBar(
        title: const Text("Mantra"),
        backgroundColor: Colors.deepOrange.shade400,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 📿 Mantra Title Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.deepOrange.shade100,
                      child: const Icon(
                        Icons.self_improvement,
                        color: Colors.deepOrange,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        mantra.id,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 📜 Mantra Content
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  mantra.sanskrit,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// 🔊 Future Actions (optional UI)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  icon: Icons.volume_up,
                  label: "Listen",
                ),
                _ActionButton(
                  icon: Icons.favorite_border,
                  label: "Save",
                ),
                _ActionButton(
                  icon: Icons.share,
                  label: "Share",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.deepOrange.shade100,
          child: Icon(icon, color: Colors.deepOrange),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

