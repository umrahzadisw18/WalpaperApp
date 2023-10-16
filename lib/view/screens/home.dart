import 'package:flutter/material.dart';
import 'package:walpaper_app/controller/fetch_walpaper.dart';
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

class WallpaperGrid extends StatelessWidget {
  final List<UnsplashImage> images;

  WallpaperGrid({required this.images});

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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("sweet"),
                  Text("sweet"),
                  Text("sweet"),
                  Text("sweet"),
                ],),
              ],
            ),
          ),
        ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (
                    (context) => WalpaperView(imageUrl: images[index].imageUrl,))));
                  },
                  child: Image.network(
                    images[index].imageUrl,
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
