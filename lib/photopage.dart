import 'main.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
// import 'dart:async';
// import 'dart:io';
// import 'package:googleapis/drive/v3.dart' as drive;
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

class PhotoPage extends StatelessWidget {
  const PhotoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: const Text('Camp App Photo Page'),
        ),
        body: MaterialApp(
          home: Gallery(),
        ));
  }
}

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<AssetEntity> assets = [];
  @override
  void initState() {
    _fetchAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gallery'),
        ),
        body: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height - 50,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                //shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // A grid view with 3 items per row
                  crossAxisCount: 3,
                ),
                itemCount: assets.length,
                itemBuilder: (_, index) {
                  return AssetThumbnail(asset: assets[index]);
                },
              )),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  print("Pressed");
                },
                child: Text("Bottom Button"),
              ))
        ]));
  }

  _fetchAssets() async {
    // Set onlyAll to true, to fetch only the 'Recent' album
    // which contains all the photos/videos in the storage
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    // Now that we got the album, fetch all the assets it contains
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 1000000, // end at a very big index (to get all the assets)
    );

    // Update the state and notify UI
    setState(() => assets = recentAssets);
  }
}

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail({
    Key? key,
    required this.asset,
  }) : super(key: key);
  final AssetEntity asset;
  @override
  Widget build(BuildContext context) {
    // We're using a FutureBuilder since thumbData is a future
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        // If we have no data, display a spinner
        if (bytes == null) return CircularProgressIndicator();
        // If there's data, display it as an image
        return InkWell(
          onTap: () {
            // TODO: navigate to Image/Video screen
          },
          onLongPress: () {},
          child: Stack(
            children: [
              // Wrap the image in a Positioned.fill to fill the space
              Positioned.fill(
                child: Image.memory(bytes, fit: BoxFit.cover),
              ),
              // Display a Play icon if the asset is a video
              if (asset.type == AssetType.video)
                Center(
                  child: Container(
                    color: Colors.blue,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      // builder: (_, snapshot) {
      //   final bytes = snapshot.data;
      //   // If we have no data, display a spinner
      //   if (bytes == null) return CircularProgressIndicator();
      //   // If there's data, display it as an image
      //   return Image.memory(bytes, fit: BoxFit.cover);
      // },
    );
  }
}

// class PhotoPage extends StatelessWidget {
//   PhotoPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         drawer: AppDrawer(),
//         appBar: AppBar(
//           title: Text('Camp App Photo Page'),
//         ),
//         body: Container(
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _images.length + 1,
//                 itemBuilder: (BuildContext context, int index) {
//                   if (index == _images.length) {
//                     return GestureDetector(
//                       onTap: () {
//                         getImage(index);
//                       },
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 5.0, right: 5, top: 10),
//                         child: Container(
//                           height: 100.0,
//                           width: 100.0,
//                           decoration: BoxDecoration(
//                             border: Border.all(),
//                             image: DecorationImage(
//                               image: AssetImage('assets/images/add_pic.jpg'),
//                               fit: BoxFit.fill,
//                             ),
//                             shape: BoxShape.rectangle,
//                           ),
//                         ),
//                       ),
//                     );
//                   }
//                   return Row(children: <Widget>[
//                     GestureDetector(
//                       onTap: () {
//                         getImage(index);
//                       },
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 5.0, right: 5, top: 10),
//                         child: Container(
//                           height: 100.0,
//                           width: 100.0,
//                           decoration: BoxDecoration(
//                             border: Border.all(),
//                             image: DecorationImage(
//                               image: FileImage(_images[index]),
//                               fit: BoxFit.fill,
//                             ),
//                             shape: BoxShape.rectangle,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]);
//                 })));
//   }
// }

// Future<drive.DriveApi?> _getDriveApi() async {
//   final googleUser = await _googleSignIn.signIn();
//   final headers = await googleUser?.authHeaders;
//   if (headers == null) {
// //      await showMessage(context, "Sign-in first", "Error");
//     return null;
//   }
//   final client = GoogleAuthClient(headers);
//   final driveApi = drive.DriveApi(client);
//   return driveApi;
// }

// final GoogleSignIn _googleSignIn = GoogleSignIn(
//   clientId: 'OAuth Client ID',
//   scopes: <String>[
//     drive.DriveApi.driveAppdataScope,
//     drive.DriveApi.driveFileScope,
//   ],
// );

// class GoogleAuthClient extends http.BaseClient {
//   final Map<String, String> _headers;
//   final _client = new http.Client();
//   GoogleAuthClient(this._headers);
//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) {
//     request.headers.addAll(_headers);
//     return _client.send(request);
//   }
// }

// List<File> _images = [];
// final picker = ImagePicker();

// Future getImage(int index) async {
//   final image = await picker.getImage(source: ImageSource.gallery);
//   _images[index] = File(image!.path);
// }

// googleSignIn.signOut();

