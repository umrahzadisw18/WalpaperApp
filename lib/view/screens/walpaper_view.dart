import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class WalpaperView extends StatefulWidget {
  final String imageUrl;
  WalpaperView({super.key, required this.imageUrl,});

  @override
  State<WalpaperView> createState() => _WalpaperViewState();
}

class _WalpaperViewState extends State<WalpaperView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<void> setWallpaper()async{
    int location= WallpaperManager.HOME_SCREEN;
    var file= await DefaultCacheManager().getSingleFile(widget.imageUrl);
    String result= (await WallpaperManager.setWallpaperFromFile(file.path, location)) as String;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
        Image.network(
          widget.imageUrl,
          fit: BoxFit.fill,
          height: double.infinity,
         // width: double.infinity,
          ),
          GestureDetector(
            onTap: (){
             // setWallpaperFromFile(imageUrl, context);
             setWallpaper();
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


  // Future<void> setWallpaperFromFile(
  //     String wallpaperUrl, BuildContext context) async {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text("Downloading Started...")));
  //   try {
  //     // Saved with this method.
  //     var imageId = await ImageDownloader.downloadImage(wallpaperUrl);
  //     if (imageId == null) {
  //       return;
  //     }
  //     // Below is a method of obtaining saved image information.
  //     var fileName = await ImageDownloader.findName(imageId);
  //     var path = await ImageDownloader.findPath(imageId);
  //     var size = await ImageDownloader.findByteSize(imageId);
  //     var mimeType = await ImageDownloader.findMimeType(imageId);
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text("Downloaded Sucessfully"),
  //       action: SnackBarAction(
  //           label: "Open",
  //           onPressed: () {
  //             OpenFile.open(path);
  //           }),
  //     ));

  //     print("IMAGE DOWNLOADED");
  //   } on PlatformException catch (error) {
  //     print(error);
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Error Occured - $error")));
  //   }
  // }
    