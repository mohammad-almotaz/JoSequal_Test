import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/wallpaper_model.dart';

class WebService {
  Future<List<WallpaperModel>> fetchWallpaper() async{
    List<WallpaperModel> image = [];
    final response = await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers:{  'Authorization':
        'jwXe1ono2ebyXyqLVzvPgckHbcBnCTqWYUrFMbz1vec6EedY9H29xGP0'} );
    if(response.statusCode==200){
      var jsonBody = jsonDecode(response.body);
      var wallpaper = jsonBody['photos'];
      for(Map i in wallpaper){
        image.add(WallpaperModel.fromJson(i));
      }
      return image;
    } else {
      throw Exception("Unable to perform request");
    }
  }
}
