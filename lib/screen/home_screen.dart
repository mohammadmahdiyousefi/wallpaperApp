import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_bloc.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_event.dart';
import 'package:wallpaper/bloc/animal/animal_photo_bloc.dart';
import 'package:wallpaper/bloc/animal/animal_photo_event.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_bloc.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_event.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_state.dart';
import 'package:wallpaper/bloc/nature/nature_photo_bloc.dart';
import 'package:wallpaper/bloc/nature/nature_photo_event.dart';
import 'package:wallpaper/bloc/people/people_photo_bloc.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_bloc.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_event.dart';
import 'package:wallpaper/screen/all_photo_screen.dart';
import 'package:wallpaper/widget/loadimage.dart';
import '../bloc/people/people_photo_event.dart';
import '../model/photo.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<Photo> allphoto = [];
  List<Photo> topphoto = [];
  List<Photo> naturephoto = [];
  List<Photo> anlimalphoto = [];
  List<Photo> peoplephoto = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocBuilder<Homebloc, IHomeState>(builder: (context, state) {
        if (state is HomeState) {
          return CustomScrollView(
            slivers: [
              state.getallphoto.fold((l) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    height: 270,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, top: 10, bottom: 10, right: 5),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                borderRadius: BorderRadius.circular(10)),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  backgroundColor: Colors.transparent),
                              child: Navgationtoallphoto(
                                titel: "All",
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<Homebloc>(context)
                                    .add(HomeAllPhotoEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(100, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text("retry")),
                        ),
                      ],
                    ),
                  ),
                );
              }, (r) {
                allphoto.clear();
                allphoto.addAll(r['photos']
                    .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                    .toList());
                return SliverToBoxAdapter(
                    child: SizedBox(
                  width: double.infinity,
                  height: 270,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, top: 10, bottom: 10, right: 5),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent),
                            onPressed: () {
                              BlocProvider.of<AllPhotoBloc>(context)
                                  .add(LoadAllPhotoEvent(1));
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return AllPhotoScreen("All");
                                },
                              ));
                            },
                            child: Navgationtoallphoto(
                              titel: "All",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: allphoto.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          itemBuilder: (context, index) {
                            return LoadeImage(allphoto[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ));
              }),
              state.gettopphoto.fold((l) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    height: 270,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, top: 10, bottom: 10, right: 5),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                borderRadius: BorderRadius.circular(10)),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  backgroundColor: Colors.transparent),
                              child: Navgationtoallphoto(
                                titel: "Top",
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<Homebloc>(context)
                                    .add(HomeTopPhotoEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(100, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text("retry")),
                        ),
                      ],
                    ),
                  ),
                );
              }, (r) {
                topphoto.clear();
                topphoto.addAll(r['photos']
                    .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                    .toList());
                return SliverToBoxAdapter(
                    child: SizedBox(
                  width: double.infinity,
                  height: 270,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, top: 10, bottom: 10, right: 5),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent),
                            onPressed: () {
                              BlocProvider.of<TopPhotoBloc>(context)
                                  .add(LoadTopPhotoEvent(1));
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return AllPhotoScreen("Top");
                                },
                              ));
                            },
                            child: Navgationtoallphoto(
                              titel: "Top",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: topphoto.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          itemBuilder: (context, index) {
                            return LoadeImage(topphoto[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ));
              }),
              state.getnaturephoto.fold((l) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    height: 270,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, top: 10, bottom: 10, right: 5),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                borderRadius: BorderRadius.circular(10)),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  backgroundColor: Colors.transparent),
                              child: Navgationtoallphoto(
                                titel: "Nature",
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<Homebloc>(context)
                                    .add(HomeNaturePhotoEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(100, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text("retry")),
                        ),
                      ],
                    ),
                  ),
                );
              }, (r) {
                naturephoto.clear();
                naturephoto.addAll(r['photos']
                    .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                    .toList());
                return SliverToBoxAdapter(
                    child: SizedBox(
                  width: double.infinity,
                  height: 270,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, top: 10, bottom: 10, right: 5),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent),
                            onPressed: () {
                              BlocProvider.of<NaturePhotoBloc>(context)
                                  .add(LoadAllNaturePhotoEvent(1));
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return AllPhotoScreen("Nature");
                                },
                              ));
                            },
                            child: Navgationtoallphoto(
                              titel: "Nature",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: naturephoto.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          itemBuilder: (context, index) {
                            return LoadeImage(naturephoto[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ));
              }),
              state.getanimalphoto.fold((l) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    height: 270,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, top: 10, bottom: 10, right: 5),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                borderRadius: BorderRadius.circular(10)),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  backgroundColor: Colors.transparent),
                              child: Navgationtoallphoto(
                                titel: "Animal",
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<Homebloc>(context)
                                    .add(HomeAnimalPhotoEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(100, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text("retry")),
                        ),
                      ],
                    ),
                  ),
                );
              }, (r) {
                anlimalphoto.clear();
                anlimalphoto.addAll(r['photos']
                    .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                    .toList());
                return SliverToBoxAdapter(
                    child: SizedBox(
                  width: double.infinity,
                  height: 270,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, top: 10, bottom: 10, right: 5),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent),
                            onPressed: () {
                              BlocProvider.of<AnimalPhotoBloc>(context)
                                  .add(LoadAllAnimalPhotoEvent(1));
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return AllPhotoScreen("Animal");
                                },
                              ));
                            },
                            child: Navgationtoallphoto(
                              titel: "Animal",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: anlimalphoto.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          itemBuilder: (context, index) {
                            return LoadeImage(anlimalphoto[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ));
              }),
              state.getpeoplephoto.fold((l) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    height: 270,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, top: 10, bottom: 10, right: 5),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                borderRadius: BorderRadius.circular(10)),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  backgroundColor: Colors.transparent),
                              child: Navgationtoallphoto(
                                titel: "People",
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<Homebloc>(context)
                                    .add(HomePeoplePhotoEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(100, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text("retry")),
                        ),
                      ],
                    ),
                  ),
                );
              }, (r) {
                peoplephoto.clear();
                peoplephoto.addAll(r['photos']
                    .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                    .toList());
                return SliverToBoxAdapter(
                    child: SizedBox(
                  width: double.infinity,
                  height: 270,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, top: 10, bottom: 10, right: 5),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent),
                            onPressed: () {
                              BlocProvider.of<PeoplePhotoBloc>(context)
                                  .add(LoadAllPeoplePhotoEvent(1));
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return AllPhotoScreen("People");
                                },
                              ));
                            },
                            child: Navgationtoallphoto(
                              titel: "People",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: peoplephoto.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          itemBuilder: (context, index) {
                            return LoadeImage(peoplephoto[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ));
              })
            ],
          );
        } else if (state is ErrorHomeState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<Homebloc>(context).add(HomeEvent());
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text("retry")),
              ),
            ],
          );
        } else {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          );
        }
      })),
    );
  }
}

// ignore: must_be_immutable
class Navgationtoallphoto extends StatelessWidget {
  Navgationtoallphoto({
    super.key,
    this.titel = '',
  });
  String titel = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titel,
        ),
        const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        )
      ],
    );
  }
}
