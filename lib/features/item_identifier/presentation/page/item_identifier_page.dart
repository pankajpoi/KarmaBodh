import 'package:flutter/material.dart';

class ItemIdentifierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ritual Item Identifier'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            // Upload / Camera buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {

                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text('Camera'),
                ),
                ElevatedButton.icon(
                  onPressed: () {

                  },
                  icon: Icon(Icons.photo_library),
                  label: Text('Gallery'),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Placeholder for image preview
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[200],
              child: Center(
                child: Text('Image...'),
              ),
            ),

            SizedBox(height: 20),

            // Identified result
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(// or NetworkImage
                ),
                title: Text("Identified Item:Item name"),
                subtitle: Text("Description of the Item"),
              ),
            ),

            // Add more results if needed
            // Expanded(child: ListView(...))

          ],
        ),
      ),
    );
  }
}
