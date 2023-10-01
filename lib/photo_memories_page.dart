import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class PhotoMemoriesPage extends StatefulWidget {
  final String destination;
  final DateTime visitDate;

  PhotoMemoriesPage({required this.destination, required this.visitDate});

  @override
  _PhotoMemoriesPageState createState() => _PhotoMemoriesPageState();
}

class _PhotoMemoriesPageState extends State<PhotoMemoriesPage> {
  List<ImageProvider> photos = [];

  _addPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        photos.add(FileImage(File(pickedFile.path)));
      });
    } else {
      print('No image selected.');
    }
  }

  _addPhotoWeb() {
    // Implementation for web (based on previous dart:html imports)
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(widget.destination),
            Text(
              "${widget.visitDate.toLocal()}".split(' ')[0],
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              setState(() {
                photos.removeAt(index);
              });
            },
            child: Image(
              image: photos[index], // Directly use the ImageProvider here
              fit: BoxFit.cover,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            kIsWeb ? _addPhotoWeb : _addPhoto, // Check if it's web or mobile
        tooltip: 'Add Photo',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
