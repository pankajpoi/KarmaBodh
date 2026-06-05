import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';
import 'package:karmbodh/features/mantras/domain/usecase/mantra_usecase.dart';
import 'package:karmbodh/features/mantras/domain/repository/mantra_repository.dart';
import 'package:karmbodh/features/mantras/presentation/page/mantra_detail_page.dart';
import 'package:karmbodh/features/mantras/presentation/provider/mantra_provider.dart';
import 'package:karmbodh/features/mantras/presentation/widgets/mantra_tile.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

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

    _controller.addListener(() {
      setState(() {});
    });
  }

  Future<void> getData() async {
    await Provider.of<MantraProvider>(
      context,
      listen: false,
    ).fetchmantras();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mantraProvider = Provider.of<MantraProvider>(context);

    final data = mantraProvider.searchmantra.isEmpty
        ? mantraProvider.mantras
        : mantraProvider.searchmantra;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F2),

      /// APP BAR
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFC2440E),
        leading: const Icon(
          Icons.self_improvement_rounded,
          color: Colors.white70,
          size: 22,
        ),
        title: Column(
          children: [
            Text(
              "Sacred Mantras",
              style: GoogleFonts.cormorantGaramond(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.white,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "Discover divine chants",
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
          /// HEADER SECTION
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
                /// HEADING ROW
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.18),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Explore Divine Chants",
                            style: GoogleFonts.cormorantGaramond(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "Find peaceful and spiritual mantras",
                            style: GoogleFonts.dmSans(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// SEARCH FIELD
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    onChanged: mantraProvider.searchmantras,
                    style: GoogleFonts.dmSans(
                      fontSize: 14.5,
                      color: const Color(0xFF3D1C08),
                    ),
                    decoration: InputDecoration(
                      hintText: "Search mantra, deity, purpose…",
                      hintStyle: GoogleFonts.dmSans(
                        color: const Color(0xFF8B5E3C).withOpacity(0.6),
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Color(0xFFC2440E),
                        size: 22,
                      ),
                      suffixIcon: _controller.text.isNotEmpty
                          ? GestureDetector(
                        onTap: () {
                          _controller.clear();
                          mantraProvider.searchmantras("");
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFC2440E)
                                .withOpacity(0.1),
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 15,
                            color: Color(0xFFC2440E),
                          ),
                        ),
                      )
                          : null,
                      border: InputBorder.none,
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// STATS PILL
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
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
                      const Icon(
                        Icons.library_books_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        "${data.length} Mantras Available",
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// LIST SECTION
          Expanded(
            child: data.isEmpty
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
                        color:
                        const Color(0xFFC2440E).withOpacity(0.14),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.self_improvement_rounded,
                      size: 38,
                      color: Color(0xFFC2440E),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "No Mantras Found",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3D1C08),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Try searching with another keyword",
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final mantra = data[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC2440E)
                              .withOpacity(0.06),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: MantraCard(mantra: mantra),
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