import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:karmbodh/features/ritual_guide/presentation/provider/Ritualguide_provider.dart';
import 'package:provider/provider.dart';


class RitualGuideApp extends StatelessWidget {
  const RitualGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ritual Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const RitualChatScreen(),
    );
  }
}

class RitualChatScreen extends StatefulWidget {
  const RitualChatScreen({super.key});

  @override
  State<RitualChatScreen> createState() => _RitualChatScreenState();
}

class _RitualChatScreenState extends State<RitualChatScreen> {

  @override
  Widget build(BuildContext context) {
    final provider=context.watch<RitualguideProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E0), // Ritual cream background
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A1C1C), // Dark maroon
        title: const Text(
          "Ritual Assistant",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // CHAT MESSAGES
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.messages.length + (provider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == provider.messages.length && provider.isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                  );
                }
                final msg = provider.messages[index];
                final isUser = msg["role"] == "user";
                return Align(
                  alignment:
                  isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(14),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      gradient: isUser
                          ? const LinearGradient(
                        colors: [Color(0xFFFF9933), Color(0xFFD97A1F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                          : null,
                      color: isUser ? null : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft: Radius.circular(isUser ? 18 : 0),
                        bottomRight: Radius.circular(isUser ? 0 : 18),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.shade200,
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Text(
                      msg["text"]!,
                      style: TextStyle(
                        color: isUser ? Colors.white : const Color(0xFF5A3E2B),
                        fontSize: 15,
                        height: 1.4,
                        fontWeight:
                        isUser ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // INPUT SECTION
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFAE6C8),
              border: Border(
                top: BorderSide(
                  color: Colors.brown.shade300,
                  width: 1.2,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: provider.controller,
                    style: const TextStyle(
                      color: Color(0xFF5A3E2B),
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: "Ask about rituals...",
                      hintStyle: TextStyle(
                        color: Colors.brown.shade500,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFFFF0D6),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.brown.shade400,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Send Button
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFF7A1C1C),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed:(){context.read<RitualguideProvider>().getresult();}
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius:25,
                  backgroundColor: const Color(0xFF7A1C1C),

                  child: IconButton(onPressed: (){}, icon: const Icon(Icons.mic),color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



