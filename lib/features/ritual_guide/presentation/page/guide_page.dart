import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:karmbodh/features/ritual_guide/presentation/provider/Ritualguide_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karmbodh/features/checklist/data/checklist_helper.dart';



class RitualGuideApp extends StatelessWidget {
  const RitualGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ritual Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC2440E)),
        useMaterial3: true,
      ),
      home: const RitualChatScreen(),
    );
  }
}



const _kPrimary = Color(0xFFC2440E);
const _kPrimaryMid = Color(0xFFE8651A);
const _kPrimaryLight = Color(0xFFF4922B);
const _kSurface = Color(0xFFFFF8F2);
const _kBubbleBg = Color(0xFFFFFAF5);
const _kTextDark = Color(0xFF3D1C08);
const _kTextMuted = Color(0xFF8B5E3C);



class RitualChatScreen extends StatefulWidget {
  const RitualChatScreen({super.key});

  @override
  State<RitualChatScreen> createState() => _RitualChatScreenState();
}

class _RitualChatScreenState extends State<RitualChatScreen> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RitualguideProvider>();
    _scrollToBottom();

    return Scaffold(
      backgroundColor: _kSurface,
      body: Column(
        children: [
          _AppHeader(),
          Expanded(
            child: provider.messages.isEmpty
                ? _EmptyState(onChipTap: (q) {
              provider.controller.text = q;
              provider.getresult();
            })
                : _ChatList(
              provider: provider,
              scrollController: _scrollController,
            ),
          ),
          _InputBar(provider: provider),
        ],
      ),
    );
  }
}



class _AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary, _kPrimaryMid, _kPrimaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
          child: Column(
            children: [
              // ── Title row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.self_improvement_rounded, color: Colors.white70, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Ritual Guide',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                'Your spiritual AI companion',
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: Colors.white60,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 16),

              // ── Info card
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 0.8,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
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
                            'Ask any ritual question',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Puja guidance, mantras & traditions answered',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: Colors.white70,
                              fontWeight: FontWeight.w300,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class _EmptyState extends StatelessWidget {
  final void Function(String) onChipTap;
  const _EmptyState({required this.onChipTap});

  static const _chips = [
    'How to perform Ganesh Puja?',
    'What is the Gayatri Mantra?',
    'Navratri rituals guide',
    'Daily morning ritual routine',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFCEADE), Color(0xFFF9C49A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: _kPrimary.withOpacity(0.14),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.self_improvement_rounded,
                size: 42,
                color: _kPrimary,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Welcome',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: _kTextDark,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ask about puja rituals, sacred mantras,\nor spiritual traditions',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: _kTextMuted,
                height: 1.6,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: _chips
                  .map((c) => _SuggestionChip(label: c, onTap: () => onChipTap(c)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SuggestionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _kPrimary.withOpacity(0.07),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _kPrimary.withOpacity(0.22), width: 0.8),
        ),
        child: Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: _kPrimary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}



class _ChatList extends StatelessWidget {
  final RitualguideProvider provider;
  final ScrollController scrollController;
  const _ChatList({required this.provider, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final itemCount =
        provider.messages.length + (provider.isLoading ? 1 : 0);

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 10),
      physics: const BouncingScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == provider.messages.length && provider.isLoading) {
          return const _TypingIndicator();
        }
        final msg = provider.messages[index];
        final isUser = msg['role'] == 'user';
        return _MessageBubble(

          text: msg['text']!,
          isUser: isUser,

          // split response into checklist items
          ritualItems: !isUser
              ? msg['text']!.split('\n')
              : null,

          onSaveChecklist: () async {

            final items =
            msg['text']!
                .split('\n')
                .where((e) => e.trim().isNotEmpty)
                .toList();

            await ChecklistDB.saveChecklistItems(
              items,
            );

            ScaffoldMessenger.of(context).showSnackBar(

              const SnackBar(
                content: Text(
                  "Saved to Checklist",
                ),
              ),
            );
          },
        );
      },
    );
  }
}



class _MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  // ritual items generated from assistant
  final List<String>? ritualItems;

  // callback to save checklist
  final VoidCallback? onSaveChecklist;

  const _MessageBubble({
    required this.text,
    required this.isUser,
    this.ritualItems,
    this.onSaveChecklist,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
      isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [

            // ───────── Label ─────────
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isUser) ...[
                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 13,
                    color: _kPrimary.withOpacity(0.75),
                  ),
                  const SizedBox(width: 5),
                ],

                Text(
                  isUser ? 'You' : 'Ritual Assistant',
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: _kPrimary.withOpacity(0.75),
                  ),
                ),

                if (isUser) ...[
                  const SizedBox(width: 5),
                  Icon(
                    Icons.person_rounded,
                    size: 13,
                    color: _kPrimary.withOpacity(0.75),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 4),


            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:
                MediaQuery.of(context).size.width * 0.78,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  gradient: isUser
                      ? const LinearGradient(
                    colors: [_kPrimary, _kPrimaryMid],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  color: isUser ? null : _kBubbleBg,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft:
                    Radius.circular(isUser ? 18 : 4),
                    bottomRight:
                    Radius.circular(isUser ? 4 : 18),
                  ),
                  border: isUser
                      ? null
                      : Border.all(
                    color: _kPrimary.withOpacity(0.14),
                    width: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _kPrimary.withOpacity(0.07),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [


                    Text(
                      text,
                      style: GoogleFonts.dmSans(
                        fontSize: 14.5,
                        height: 1.65,
                        fontWeight: FontWeight.w400,
                        color: isUser
                            ? Colors.white
                            : _kTextDark,
                      ),
                    ),


                    if (!isUser &&
                        ritualItems != null &&
                        ritualItems!.isNotEmpty) ...[
                      const SizedBox(height: 14),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          borderRadius:
                          BorderRadius.circular(12),
                          onTap: onSaveChecklist,
                          child: Container(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              gradient:
                              const LinearGradient(
                                colors: [
                                  _kPrimary,
                                  _kPrimaryMid,
                                ],
                              ),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize:
                              MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.checklist_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),

                                const SizedBox(width: 8),

                                Text(
                                  "Save to Checklist",
                                  style:
                                  GoogleFonts.dmSans(
                                    color: Colors.white,
                                    fontWeight:
                                    FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 



class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
    _anims = List.generate(3, (i) {
      final start = i * 0.2;
      return Tween(begin: 0.35, end: 1.0).animate(
        CurvedAnimation(
          parent: _ctrl,
          curve: Interval(start, start + 0.4, curve: Curves.easeInOut),
        ),
      );
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: _kBubbleBg,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomRight: Radius.circular(18),
            bottomLeft: Radius.circular(4),
          ),
          border: Border.all(color: _kPrimary.withOpacity(0.14), width: 0.8),
          boxShadow: [
            BoxShadow(
              color: _kPrimary.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(3, (i) {
              return AnimatedBuilder(
                animation: _anims[i],
                builder: (_, __) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _kPrimary.withOpacity(_anims[i].value),
                  ),
                ),
              );
            }),
            const SizedBox(width: 10),
            Text(
              'Seeking guidance…',
              style: GoogleFonts.dmSans(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: _kTextMuted,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class _InputBar extends StatelessWidget {
  final RitualguideProvider provider;
  const _InputBar({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: _kPrimary.withOpacity(0.1),
            width: 0.8,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ── Text field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E8),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: _kPrimary.withOpacity(0.2),
                    width: 0.8,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 13),
                      child: Icon(
                        Icons.temple_hindu_rounded,
                        color: _kPrimary.withOpacity(0.55),
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: provider.controller,
                        minLines: 1,
                        maxLines: 4,
                        style: GoogleFonts.dmSans(
                          fontSize: 14.5,
                          color: _kTextDark,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Ask about rituals, puja, mantras…',
                          hintStyle: GoogleFonts.dmSans(
                            color: _kTextMuted.withOpacity(0.7),
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 10),



            // ── Send button
            GestureDetector(
              onTap: () => context.read<RitualguideProvider>().getresult(),
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [_kPrimary, _kPrimaryMid],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _kPrimary.withOpacity(0.32),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final bool bordered;
  const _CircleButton({
    required this.onTap,
    required this.child,
    this.bordered = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bordered ? const Color(0xFFFFF3E8) : Colors.transparent,
          border: bordered
              ? Border.all(color: _kPrimary.withOpacity(0.2), width: 0.8)
              : null,
        ),
        child: Center(child: child),
      ),
    );
  }
}



