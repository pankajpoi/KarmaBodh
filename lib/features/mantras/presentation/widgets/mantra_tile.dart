import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/presentation/provider/mantra_provider.dart';
import 'package:provider/provider.dart';

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
