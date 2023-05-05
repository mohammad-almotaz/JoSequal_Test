
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_app/helpers/fav_database.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';



class WallpaperDetails extends StatefulWidget {
  WallpaperModel wallpaperModel;

  WallpaperDetails({
    super.key,
    required this.wallpaperModel,
  });

  @override
  State<WallpaperDetails> createState() => _WallpaperDetailsState();
}

class _WallpaperDetailsState extends State<WallpaperDetails> {
  FavDataBase favDataBase = FavDataBase();
  bool isFav = false;


  @override
  void initState() {
    super.initState();
    favDataBase.checkIsFav(id: widget.wallpaperModel.id).then(
      (value) {
        isFav = value == widget.wallpaperModel.id;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallpaper Details")),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Image.network(
                  widget.wallpaperModel.src.tiny,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.wallpaperModel.photographer,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    await launchUrl(
                      Uri.parse(widget.wallpaperModel.photographerUrl),
                    );
                  },
                  child: Text(
                    widget.wallpaperModel.photographerUrl,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (isFav) {
                        await favDataBase.deleteSRC(id: widget.wallpaperModel.id);
                        await favDataBase.delete(id: widget.wallpaperModel.id);

                      } else {
                        await favDataBase.insert(
                          wallpaperModel: widget.wallpaperModel,
                        );
                        await favDataBase.insertSRC(srcModel: widget.wallpaperModel.src);
                      }
                      isFav = !isFav;
                      setState(() {});
                    },
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _saveNetworkVideo();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child: Text(
                  'Download Wallpaper',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveNetworkVideo() async {
    String path =
        '${widget.wallpaperModel.src.original}';
    GallerySaver.saveImage(path).then((value) {

    },);
  }

}


