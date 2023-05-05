import 'package:flutter/material.dart';

import '../helpers/fav_database.dart';
import '../model/src_model.dart';
import '../model/wallpaper_model.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavDataBase favDataBase = FavDataBase();
  List<WallpaperModel> list = [];
  List<SrcModel> listSrc = [];

  @override
  void initState() {
    super.initState();
    favDataBase.selectAllSrc().then((value) {
      listSrc = value;
      setState(() {

      });
    },);

    favDataBase.selectAllFav().then(
      (value) {
        list = value;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Page"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  /*onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WallpaperDetails(
                              wallpaperModel: wallpaperListViewModel
                                  .list[index].wallpaperModel,
                            ),
                          ));
                    },*/
                  child: Container(
                    color: Colors.white,
                    child: Image.network(
                      listSrc[index].tiny,
                      fit: BoxFit.cover,
                    ),
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
