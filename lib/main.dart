import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/bloc/allphotobloc/all_photo_bloc.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_state.dart';
import 'package:wallpaper/bloc/animal/animal_photo_bloc.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_bloc.dart';
import 'package:wallpaper/bloc/nature/nature_photo_bloc.dart';
import 'package:wallpaper/bloc/people/people_photo_bloc.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_bloc.dart';
import 'package:wallpaper/screen/all_photo_screen.dart';
import 'package:wallpaper/screen/swith_page.dart';

void main() {
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
    })
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 183, 131)),
        useMaterial3: true,
      ),
      home: const SwithPage(),
    );
  }
}
