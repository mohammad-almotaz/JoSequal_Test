import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/view/wallpaper_details_view.dart';

import '../model/wallpaper_model.dart';

class SearchWallpaper extends StatefulWidget {
  const SearchWallpaper({Key? key}) : super(key: key);

  @override
  State<SearchWallpaper> createState() => _SearchWallpaperState();
}

class _SearchWallpaperState extends State<SearchWallpaper> {
  TextEditingController searchBarController = TextEditingController();
  List image = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Page")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 50,
              child: TextField(
                controller: searchBarController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        searchForWallpaper();
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: GridView.builder(
                itemCount: image.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => WallpaperDetails(
                      //             wallpaperModel: image
                      //                 .list[index].wallpaperModel),
                      //       ));
                      // },
                    },
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        image[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  searchForWallpaper() async {
    await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=${searchBarController.text}&per_page=15'),
        headers: {
          'Authorization':
              'jwXe1ono2ebyXyqLVzvPgckHbcBnCTqWYUrFMbz1vec6EedY9H29xGP0'
        }).then(
      (value) {
        Map result = jsonDecode(value.body);

        setState(() {
          image = result['photos'];
        });
      },
    );
  }
}
