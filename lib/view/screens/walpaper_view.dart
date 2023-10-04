import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:open_file/open_file.dart';

class WalpaperView extends StatelessWidget {
  final String imageUrl;
  WalpaperView({super.key, required this.imageUrl,});

   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<void> setWallpaperFromFile(
      String wallpaperUrl, BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Downloading Started...")));
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(wallpaperUrl);
      if (imageId == null) {
        return;
      }
      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Downloaded Sucessfully"),
        action: SnackBarAction(
            label: "Open",
            onPressed: () {
              OpenFile.open(path);
            }),
      ));
      print("IMAGE DOWNLOADED");
    } on PlatformException catch (error) {
      print(error);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured - $error")));
    }
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
        Image.network(
          imageUrl,
          fit: BoxFit.fill,
          height: 700,
          width: double.infinity,),
          GestureDetector(
            onTap: (){
              setWallpaperFromFile(imageUrl, context);
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  margin: EdgeInsets.only(bottom: 18),
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(
                    child: Text("Set Wallpaper",
                    style: TextStyle(
                      color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600
                    ),),
                  ),),
              )),
          )
      ]),
    );
  }
}