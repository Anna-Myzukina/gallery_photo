import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class PhotoGallery extends StatefulWidget {
  PhotoGallery({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  List data;

  Future<String> getJSONData() async {
    var response = await http.get(
        Uri.encodeFull(
            'https://api.unsplash.com/search/photos?per_page=30&client_id=dfqsEYaio2KCdHlw6DnPn78ThED05Bx5LCN3XQlmFUA&query=office'),
        headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(response.body)['results'];
    });

    return "sucessful";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.red[200],
                    title: Text("Back to Gallery"),
                  ),
                  body: _fullScareenImage(data[index]),
                );
              },
            ),
          );
        },
        child: _buildImageColumn(data[index]),
      ),
    );
  }

  Widget _fullScareenImage(dynamic item) => Container(
        child: new CachedNetworkImage(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          imageUrl: item['urls']['full'],
          placeholder: (context, url) => new CircularProgressIndicator(),
          fit: BoxFit.cover,
        ),
      );

  Widget _buildImageColumn(dynamic item) => Container(
      decoration: BoxDecoration(color: Colors.green[100]),
      margin: const EdgeInsets.all(1),
      child: Column(
        children: [
          new CachedNetworkImage(
            imageUrl: item['urls']['small'],
            placeholder: (context, url) => new CircularProgressIndicator(),
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(item['user']['name']),
            subtitle: Text(
                item['alt_description'] == null ? '' : item['alt_description']),
          ),
        ],
      ));

  @override
  void initState() {
    super.initState();
    this.getJSONData();
  }
}
