import 'package:flutter/cupertino.dart';
import 'package:wallpaper_app/model/src_model.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/helpers/web_service.dart';

class WallpaperListViewModel extends ChangeNotifier {
  List<WallpaperViewModel> list = [];

  fetchWallpaperFinal() async {
    final results = await WebService().fetchWallpaper();
    list = results.map((e) => WallpaperViewModel(wallpaperModel: e)).toList();
    notifyListeners();
  }
}

class WallpaperViewModel {
  final WallpaperModel wallpaperModel;

  WallpaperViewModel({required this.wallpaperModel});

  int get Id {
    return wallpaperModel.id;
  }

  int get Width {
    return wallpaperModel.width;
  }

  int get Height {
    return wallpaperModel.height;
  }

  String get Url {
    return wallpaperModel.url;
  }

  String get Photographer {
    return wallpaperModel.photographer;
  }

  String get PhotographerUrl {
    return wallpaperModel.photographerUrl;
  }

  int get PhotographerId {
    return wallpaperModel.photographerId;
  }

  String get AvgColor {
    return wallpaperModel.avgColor;
  }

  SrcModel get srcModel {
    return wallpaperModel.src;
  }

  String get Alt {
    return wallpaperModel.alt;
  }

  bool get Liked {
    return wallpaperModel.liked;
  }
}
