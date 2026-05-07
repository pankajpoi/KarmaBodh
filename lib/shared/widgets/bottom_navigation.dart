import 'package:flutter/material.dart';
import 'package:karmbodh/features/calendar/presentation/page/calendar/calendar_page.dart';
import 'package:karmbodh/features/checklist/presentation/widget/checklist_widget.dart';
import 'package:karmbodh/features/item_identifier/presentation/page/item_identifier_page.dart';
import 'package:karmbodh/features/mantras/presentation/page/mantra_list_page.dart';
import 'package:karmbodh/features/ritual_guide/presentation/page/guide_page.dart';
import 'package:karmbodh/features/checklist/presentation/page/checklist_page.dart';
import 'package:karmbodh/features/calender.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selecteditem=0;
  final List<Widget> _pages=[
    CalendarPage(),
    RitualGuideApp(),
    ItemIdentifierScreen(),
    MantraListPage(),
    Text("checklist"),
  ];

  void _onitemTapped(int index){
    _selecteditem=index;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selecteditem],
      bottomNavigationBar: Container(
        color: Colors.green,
        child: BottomNavigationBar(
            backgroundColor: Colors.deepOrange,
            unselectedItemColor: Colors.blue,
            selectedItemColor: Colors.blue,
            currentIndex: _selecteditem,
            onTap: _onitemTapped,
            items: [
              BottomNavigationBarItem(icon:Icon(Icons.calendar_month),label:"Calender" ),
              BottomNavigationBarItem(icon: Icon(Icons.book),label:"Ritual"),
              BottomNavigationBarItem(icon: Icon(Icons.camera_alt),label:"Identifier"),
              BottomNavigationBarItem(icon: Icon(Icons.music_note),label:"Mantra"),
              BottomNavigationBarItem(icon: Icon(Icons.checklist),label:"Checklist"),

            ]),
      ),
    );
  }
}
