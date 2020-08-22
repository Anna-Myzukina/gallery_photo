import 'package:flutter/material.dart';
import 'screens/photo_gallery.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Gallery',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PhotoGallery(title: 'Enjoy your Photo Gallery'),
    );
  }
}
