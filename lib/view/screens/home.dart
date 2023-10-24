import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:walpaper_app/controller/fetch_walpaper.dart';
import 'package:walpaper_app/model/category_model.dart';
import 'package:walpaper_app/model/model.dart';
import 'package:walpaper_app/view/screens/walpaper_view.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UnsplashImage>>(
      future: fetchWallpapers(),
      builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator()); // Show a loading indicator while fetching data
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Text('No wallpapers available.');
    } else {
      return WallpaperGrid(images: snapshot.data!);
    }
  },
);
  }
}

class WallpaperGrid extends StatefulWidget {
  final List<UnsplashImage> images;

  WallpaperGrid({required this.images});

  @override
  State<WallpaperGrid> createState() => _WallpaperGridState();
}

class _WallpaperGridState extends State<WallpaperGrid> {
 List<CategorieModel> categories = [];

@override
  void initState() {
    categories = getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("W A L L P A P E R"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        ),
        
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: TextField(decoration: InputDecoration(
              labelText: "search",
              labelStyle: TextStyle(color: Colors.white),
              hintText: "search wallpaper",
              filled: true,
              //fillColor: Colors.grey.shade300,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              )),
              ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            height: 80,
            child:ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      /// Create List Item tile
                      return CategoriesTile(
                        imgUrls: categories[index].imgUrl,
                        categorie: categories[index].categorieName,
                      );
                    }),
          ),
        ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (
                    (context) => WalpaperView(imageUrl: widget.images[index].imageUrl,))));
                  },
                  child: Image.network(
                    widget.images[index].imageUrl,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class CategoriesTile extends StatelessWidget {
  final String imgUrls, categorie;

  CategoriesTile({required this.imgUrls, required this.categorie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CategorieScreen(
        //               categorie: categorie,
        //             )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: kIsWeb
            ? Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls,
                              height: 50,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls,
                              height: 50,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        categorie,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Overpass'),
                      )),
                ],
              )
            : Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls,
                              height: 50,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls,
                              height: 50,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                      height: 50,
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        categorie ?? "Yo Yo",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Overpass'),
                      ))
                ],
              ),
      ),
    );
  }
}