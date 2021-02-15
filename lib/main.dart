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
        primarySwatch: Colors.blue,
      ),
      home: PhotoGallery(title: 'Try your Photo Gallery'),
    );
  }
}
