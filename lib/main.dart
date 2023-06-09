import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/view/favorite_view.dart';
import 'package:wallpaper_app/view/home_view.dart';
import 'package:wallpaper_app/view_model/wallpaper_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WallpaperListViewModel>(
            create: (context) => WallpaperListViewModel())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
