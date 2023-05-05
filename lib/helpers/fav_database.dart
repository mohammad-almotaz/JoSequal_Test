import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallpaper_app/model/src_model.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';

class FavDataBase {
  Database? database;
  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  openDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'fav.db');
    database = await openDatabase(path, onConfigure: _onConfigure,version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE photos (id INTEGER PRIMARY KEY,width INTEGER,height INTEGER,url TEXT, photographer TEXT,photographer_url TEXT,photographer_id INTEGER, avg_color TEXT,src TEXT, liked INTEGER, alt TEXT)');
      await db.execute(
          'CREATE TABLE src (id INTEGER PRIMARY KEY,original TEXT,large2x TEXT,large TEXT,medium TEXT,small TEXT,portrait TEXT,landscape TEXT,tiny TEXT, photos_id INTEGER, FOREIGN KEY (photos_id) REFERENCES photos(id) )');
    });
  }

  insertSRC({required SrcModel srcModel}) async {
    await openDataBase();
    database!.insert("src", srcModel.toJson());
    database!.close();
  }

  insert({required WallpaperModel wallpaperModel}) async {
    await openDataBase();
    database!.insert("photos", wallpaperModel.toJson());
    // database!.rawInsert(
    //     "Insert into photos (id,width ,height ,url , photographer ,photographer_url ,photographer_id , avg_color ,src , liked , alt ) Values('${wallpaperModel.id}','${wallpaperModel.width}','${wallpaperModel.height}','${wallpaperModel.url}','${wallpaperModel.photographer}','${wallpaperModel.photographerUrl}','${wallpaperModel.photographerId}','${wallpaperModel.avgColor}','${wallpaperModel.src.toJson()}','${wallpaperModel.liked}','${wallpaperModel.alt}') ");

    database!.close();
  }

  delete({required var id}) async {
    await openDataBase();
    await database!.delete("photos", where: 'id = ?', whereArgs: [id]);
    database!.close();
  }

  deleteSRC({required var id}) async{
    await openDataBase();
    await database!.delete("src", where: 'photos_id=?',whereArgs: [id]);
    database!.close();
  }


  Future<List<WallpaperModel>> selectAllFav() async {
    List<WallpaperModel> listWallpaperModel = [];
    await openDataBase();
    List<Map> list = await database!.rawQuery("SELECT * FROM photos ");
    database!.close();
    for (Map i in list) {
      listWallpaperModel.add(WallpaperModel.fromJson(i));
    }
    return listWallpaperModel;
  }

  Future<List<SrcModel>> selectAllSrc()async{
    List<SrcModel> listSrcModel = [];
    await openDataBase();
    List<Map> listSrc = await database!.rawQuery("SELECT * FROM src");
    database!.close();
    for(Map i in listSrc){
      listSrcModel.add(SrcModel.fromJson(i));
    }
    return listSrcModel;
  }

  Future<int> checkIsFav({required var id}) async {
    await openDataBase();
    List<Map> list =
        await database!.rawQuery("SELECT * FROM photos where id = '$id' ");
    database!.close();
    if (list.isEmpty) {
      return -1;
    } else {
      return list[0]['id'];
    }
  }
}
