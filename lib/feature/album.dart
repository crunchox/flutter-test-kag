import 'package:flutter/material.dart';
import 'package:kapal_api_group_tech_test/model/photo.dart';
import 'package:kapal_api_group_tech_test/myapiservice.dart';

class AlbumPage extends StatefulWidget {
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late List<Photo?>? allListPhotos;
  late List<Photo?>? listPhotos = [];

  @override
  void initState() {
    super.initState();
    MyApiService().getPhoto().then((value) => setPhoto(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album Page'),
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: listPhotos != null
                ? ListView.builder(
                    itemCount: listPhotos?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final model = listPhotos?[index];
                      return Card(
                        child: Column(
                          children: [
                            Image.network(model?.thumbnailUrl ?? ''),
                            ListTile(
                              title: Text(model?.title ?? ''),
                            ),
                          ],
                        ),
                      );
                    })
                : null),
      ),
    );
  }

  void setPhoto(List<Photo>? list) {
    if (list != null) {
      setState(() {
        allListPhotos = list;
        listPhotos = list.where((photo) => photo.albumId == 1).toList();
      });
    }
  }
}
