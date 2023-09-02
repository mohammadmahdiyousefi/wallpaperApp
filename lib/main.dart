import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/bloc/allphotobloc/all_photo_bloc.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_state.dart';
import 'package:wallpaper/bloc/animal/animal_photo_bloc.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_bloc.dart';
import 'package:wallpaper/bloc/nature/nature_photo_bloc.dart';
import 'package:wallpaper/bloc/people/people_photo_bloc.dart';
import 'package:wallpaper/bloc/savephoto/save_photo_bloc.dart';
import 'package:wallpaper/bloc/search/search_bloc.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_bloc.dart';
import 'package:wallpaper/screen/all_photo_screen.dart';
import 'package:wallpaper/screen/swith_page.dart';
import 'package:wallpaper/theme/colors_schemes.dart';

import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  await Hive.initFlutter();
  await Hive.openBox('photo');
  await Hive.openBox('theme');
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) {
      return AllPhotoBloc();
    }),
    BlocProvider(create: (context) {
      return Homebloc();
    }),
    BlocProvider(create: (context) {
      return TopPhotoBloc();
    }),
    BlocProvider(create: (context) {
      return NaturePhotoBloc();
    }),
    BlocProvider(create: (context) {
      return AnimalPhotoBloc();
    }),
    BlocProvider(create: (context) {
      return PeoplePhotoBloc();
    }),
    BlocProvider(create: (context) {
      return SavePhotoBloc();
    }),
    BlocProvider(create: (context) {
      return SearchBloc();
    })
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  var box = Hive.box("theme");
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, value, child) {
          return MaterialApp(
            themeAnimationDuration: const Duration(seconds: 0),
            debugShowCheckedModeBanner: false,
            themeMode: value.get("mode", defaultValue: false) == true
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
            darkTheme:
                ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
            home: const SwithPage(),
          );
        });
  }
}
