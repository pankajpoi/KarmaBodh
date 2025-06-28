import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/presentation/page/mantra_list_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selecteditem=0;
  final List<Widget> _pages=[
    Text("calender"),
    Text("ritual guide"),
    Text("item identifier"),
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
