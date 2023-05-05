import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/helpers/fav_database.dart';
import 'package:wallpaper_app/view/favorite_view.dart';
import 'package:wallpaper_app/view/search_wallpaper_view.dart';
import 'package:wallpaper_app/view/wallpaper_details_view.dart';
import 'package:wallpaper_app/view_model/wallpaper_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();
    Provider.of<WallpaperListViewModel>(context, listen: false)
        .fetchWallpaperFinal();
  }

  @override
  Widget build(BuildContext context) {
    final wallpaperListViewModel = Provider.of<WallpaperListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallpaper App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchWallpaper(),
                  ));
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteScreen(),
                  ));
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: wallpaperListViewModel.list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WallpaperDetails(
                                wallpaperModel: wallpaperListViewModel
                                    .list[index].wallpaperModel,
                              ),
                            ));
                      },
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                          wallpaperListViewModel.list[index].srcModel.tiny,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
