import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/domain/entity/mantras_entity.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';

class MantraDetailPage extends StatefulWidget {
  final Mantra mantra;

  const MantraDetailPage({
    super.key,
    required this.mantra,
  });

  @override
  State<MantraDetailPage> createState() => _MantraDetailPageState();
}

class _MantraDetailPageState extends State<MantraDetailPage> {
  final AudioPlayer player = AudioPlayer();

  bool isPlaying = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    /// Listen for player state changes
    player.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state.playing;
        });

        if (state.processingState == ProcessingState.completed) {
          player.stop();
        }
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  /// Audio play/pause
  Future<void> playAudio() async {
    /// Handle null or empty audio
    if (widget.mantra.audio == null ||
        widget.mantra.audio!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Audio is not available for this mantra."),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      if (isPlaying) {
        await player.pause();
      } else {
        /// Load asset
        await player.setAsset(widget.mantra.audio!);
        await player.play();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to play audio: $e")),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F2),

      /// APP BAR
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFC2440E),
        foregroundColor: Colors.white,
        leading: const BackButton(color: Colors.white),
        title: Column(
          children: [
            Text(
              "Mantra",
              style: GoogleFonts.cormorantGaramond(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFC2440E),
                    Color(0xFFE8651A),
                    Color(0xFFF4922B),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFC2440E).withOpacity(0.22),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  /// ICON
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.18),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.self_improvement_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sacred Mantra",
                          style: GoogleFonts.dmSans(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.mantra.id,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// SANSKRIT
            _buildSectionCard(
              title: "Sanskrit Mantra",
              icon: Icons.auto_awesome,
              child: Text(
                widget.mantra.sanskrit,
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 22,
                  height: 1.9,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF3D1C08),
                  letterSpacing: 0.4,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// TRANSLATION
            _buildSectionCard(
              title: "Meaning / Translation",
              icon: Icons.translate_rounded,
              child: Text(
                widget.mantra.translation,
                style: GoogleFonts.dmSans(
                  fontSize: 15,
                  height: 1.8,
                  color: const Color(0xFF3D1C08),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// USAGE
            _buildSectionCard(
              title: "Usage & Benefits",
              icon: Icons.menu_book_rounded,
              child: Column(
                children: widget.mantra.usage
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key + 1;
                  final usage = entry.value;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCEADE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFC2440E).withOpacity(0.12),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFC2440E),
                                Color(0xFFE8651A),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "$index",
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            usage,
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              height: 1.65,
                              color: const Color(0xFF3D1C08),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 28),

            /// ACTION BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  icon: isLoading
                      ? Icons.hourglass_top
                      : isPlaying
                      ? Icons.pause_rounded
                      : Icons.volume_up_rounded,
                  label: isLoading
                      ? "Loading"
                      : isPlaying
                      ? "Pause"
                      : "Listen",
                  onTap: playAudio,
                  isPrimary: true,
                ),

                _ActionButton(
                  icon: Icons.favorite_border_rounded,
                  label: "Save",
                  onTap: () {},
                ),

                _ActionButton(
                  icon: Icons.share_rounded,
                  label: "Share",
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ACTION BUTTON
// ─────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isPrimary
                  ? const LinearGradient(
                colors: [Color(0xFFC2440E), Color(0xFFE8651A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
                  : const LinearGradient(
                colors: [Color(0xFFFCEADE), Color(0xFFFFF0E0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: const Color(0xFFC2440E).withOpacity(
                  isPrimary ? 0.0 : 0.18,
                ),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFC2440E).withOpacity(
                    isPrimary ? 0.28 : 0.1,
                  ),
                  blurRadius: isPrimary ? 12 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: isPrimary ? Colors.white : const Color(0xFFC2440E),
              size: 26,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF3D1C08),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  SECTION CARD BUILDER
// ─────────────────────────────────────────────

Widget _buildSectionCard({
  required String title,
  required IconData icon,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFAF5),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color: const Color(0xFFC2440E).withOpacity(0.1),
        width: 0.8,
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFC2440E).withOpacity(0.06),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// SECTION HEADER
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: const Color(0xFFFCEADE),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFC2440E).withOpacity(0.15),
                  width: 0.8,
                ),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFC2440E),
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3D1C08),
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Divider(
          color: const Color(0xFFC2440E).withOpacity(0.1),
          thickness: 0.8,
        ),

        const SizedBox(height: 12),

        child,
      ],
    ),
  );
}
