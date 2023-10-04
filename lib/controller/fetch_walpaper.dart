import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:walpaper_app/model/model.dart';

Future<List<UnsplashImage>> fetchWallpapers() async {
  final response = await http.get(
    Uri.parse('https://api.unsplash.com/photos/random?count=10'), // Replace with your API endpoint
    headers: {
      'Authorization': 'Client-ID UJjdKF3XNCT6meGgD_BDMT6UUV6t-IDVQQ7racv4Dlc', // Replace with your API key
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    final List<UnsplashImage> images = jsonList.map((json) => UnsplashImage.fromJson(json)).toList();
    return images;
  } else {
    // Handle errors
    throw Exception('Failed to load wallpapers');
  }
}