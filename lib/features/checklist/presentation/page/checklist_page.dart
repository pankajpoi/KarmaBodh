import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import "package:karmbodh/features/checklist/data/checklist_helper.dart";

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    items = await ChecklistDB.getItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final doneCount = items.where((e) => e['isDone'] == 1).length;
    final totalCount = items.length;
    final progress = totalCount == 0 ? 0.0 : doneCount / totalCount;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F2),


      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFC2440E),
        leading: const Icon(Icons.self_improvement_rounded, color: Colors.white70, size: 22),
        title: Column(
          children: [
            Text(
              "Ritual Checklist",
              style: GoogleFonts.cormorantGaramond(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.white,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "Track your sacred preparations",
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: Colors.white60,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [


          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFC2440E),
                  Color(0xFFE8651A),
                  Color(0xFFF4922B),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(26),
                bottomRight: Radius.circular(26),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  children: [

                    _StatPill(
                      icon: Icons.check_circle_rounded,
                      label: "$doneCount Done",
                    ),
                    const SizedBox(width: 10),

                    _StatPill(
                      icon: Icons.radio_button_unchecked_rounded,
                      label: "${totalCount - doneCount} Remaining",
                    ),
                    const Spacer(),
                    _StatPill(
                      icon: Icons.list_rounded,
                      label: "$totalCount Total",
                    ),
                  ],
                ),

                const SizedBox(height: 16),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Progress",
                          style: GoogleFonts.dmSans(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          "${(progress * 100).toInt()}%",
                          style: GoogleFonts.cormorantGaramond(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 7,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// LIST
          Expanded(
            child: items.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFCEADE),
                          Color(0xFFF9C49A),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: const Color(0xFFC2440E).withOpacity(0.14),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.checklist_rounded,
                      size: 38,
                      color: Color(0xFFC2440E),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "No Items Yet",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3D1C08),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Add your ritual preparations below",
                    style: GoogleFonts.dmSans(
                      color: const Color(0xFF8B5E3C),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 100),
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isDone = item['isDone'] == 1;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDone
                          ? const Color(0xFFFCEADE).withOpacity(0.6)
                          : const Color(0xFFFFFAF5),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isDone
                            ? const Color(0xFFC2440E).withOpacity(0.22)
                            : const Color(0xFFC2440E).withOpacity(0.1),
                        width: 0.8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC2440E)
                              .withOpacity(isDone ? 0.08 : 0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [

                        /// CHECKBOX
                        GestureDetector(
                          onTap: () async {
                            await ChecklistDB.updateItem(
                              item['id'],
                              isDone ? 0 : 1,
                            );
                            loadItems();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(14),
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: isDone
                                  ? const LinearGradient(
                                colors: [
                                  Color(0xFFC2440E),
                                  Color(0xFFE8651A),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                                  : null,
                              color: isDone ? null : Colors.transparent,
                              border: isDone
                                  ? null
                                  : Border.all(
                                color: const Color(0xFFC2440E)
                                    .withOpacity(0.35),
                                width: 1.5,
                              ),
                            ),
                            child: isDone
                                ? const Icon(
                              Icons.check_rounded,
                              size: 15,
                              color: Colors.white,
                            )
                                : null,
                          ),
                        ),

                        /// TITLE
                        Expanded(
                          child: Text(
                            item['title'],
                            style: GoogleFonts.dmSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: isDone
                                  ? const Color(0xFF8B5E3C)
                                  : const Color(0xFF3D1C08),
                              decoration: isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationColor: const Color(0xFF8B5E3C),
                            ),
                          ),
                        ),

                        /// DELETE BUTTON
                        GestureDetector(
                          onTap: () async {
                            await ChecklistDB.deleteItem(item['id']);
                            loadItems();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFC2440E)
                                  .withOpacity(0.08),
                            ),
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              size: 18,
                              color: Color(0xFFC2440E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class _StatPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.25),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}