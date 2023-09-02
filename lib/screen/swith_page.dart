import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_bloc.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_event.dart';
import 'package:wallpaper/bloc/animal/animal_photo_bloc.dart';
import 'package:wallpaper/bloc/animal/animal_photo_event.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_bloc.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_event.dart';
import 'package:wallpaper/bloc/nature/nature_photo_bloc.dart';
import 'package:wallpaper/bloc/nature/nature_photo_event.dart';
import 'package:wallpaper/bloc/people/people_photo_bloc.dart';
import 'package:wallpaper/bloc/people/people_photo_event.dart';
import 'package:wallpaper/bloc/savephoto/save_photo_bloc.dart';
import 'package:wallpaper/bloc/savephoto/save_photo_event.dart';
import 'package:wallpaper/bloc/savephoto/save_photo_state.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_bloc.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_event.dart';
import 'package:wallpaper/screen/all_photo_screen.dart';
import 'package:wallpaper/screen/home_screen.dart';
import 'package:wallpaper/screen/savescreen.dart';
import 'package:wallpaper/screen/searchscreen.dart';
import 'package:wallpaper/screen/seting_screen.dart';

class SwithPage extends StatefulWidget {
  const SwithPage({super.key});

  @override
  State<SwithPage> createState() => _SwithPageState();
}

class _SwithPageState extends State<SwithPage> {
  List<Widget> page = [
    const SetingScreen(),
    SearchScreen(),
    HomePage(),
    const SavePhotoScreen()
  ];
  int index = 2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: page),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) async {
            setState(() {
              index = value;
            });
            if (value == 2) {
              // BlocProvider.of<AllPhotoBloc>(context).add(AllPhotoEvent());
              // await Future.delayed(Duration(seconds: 3));
              // BlocProvider.of<TopPhotoBloc>(context).add(TopPhotoEvent());
              // await Future.delayed(Duration(seconds: 3));
              // BlocProvider.of<NaturePhotoBloc>(context).add(NaturePhotoEvent());
              // await Future.delayed(Duration(seconds: 3));
              // BlocProvider.of<AnimalPhotoBloc>(context).add(AnimalPhotoEvent());
              // await Future.delayed(Duration(seconds: 3));
              // BlocProvider.of<PeoplePhotoBloc>(context).add(PeoplePhotoEvent());
            } else if (value == 3) {
              BlocProvider.of<SavePhotoBloc>(context).add(LoadSavePhotoEvent());
            }
          },
          selectedItemColor: Colors.green,
          unselectedItemColor: Theme.of(context).colorScheme.onBackground,
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: "Settings"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Saved"),
          ]),
    );
  }

  void get() async {
    BlocProvider.of<Homebloc>(context).add(HomeEvent());
    // BlocProvider.of<AllPhotoBloc>(context).add(AllPhotoEvent());
    // await Future.delayed(Duration(seconds: 3));
    // BlocProvider.of<TopPhotoBloc>(context).add(TopPhotoEvent());
    // await Future.delayed(Duration(seconds: 3));
    // BlocProvider.of<NaturePhotoBloc>(context).add(NaturePhotoEvent());
    // await Future.delayed(Duration(seconds: 3));
    // BlocProvider.of<AnimalPhotoBloc>(context).add(AnimalPhotoEvent());
    // await Future.delayed(Duration(seconds: 3));
    // BlocProvider.of<PeoplePhotoBloc>(context).add(PeoplePhotoEvent());
  }
}
