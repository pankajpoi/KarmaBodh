import 'package:flutter/material.dart';

class ChecklistSection extends StatefulWidget {
  final String title;
  final List<String> items;

  const ChecklistSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<ChecklistSection> createState() => _ChecklistSectionState();
}

class _ChecklistSectionState extends State<ChecklistSection> {
  bool expanded = false;
  late List<bool> checked;

  @override
  void initState() {
    super.initState();
    checked = List.filled(widget.items.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            trailing: Icon(expanded ? Icons.expand_less : Icons.expand_more),
            onTap: () => setState(() => expanded = !expanded),
          ),

          if (expanded)
            Column(
              children: List.generate(widget.items.length, (index) {
                return CheckboxListTile(
                  value: checked[index],
                  onChanged: (value) {
                    setState(() {
                      checked[index] = value!;
                    });
                  },
                  title: Text(widget.items[index]),
                );
              }),
            ),
        ],
      ),
    );
  }
}
