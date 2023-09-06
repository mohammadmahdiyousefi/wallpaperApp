import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photofetchpro/bloc/allphotobloc/all_photo_bloc.dart';
import 'package:photofetchpro/bloc/allphotobloc/all_photo_event.dart';
import 'package:photofetchpro/bloc/animal/animal_photo_bloc.dart';
import 'package:photofetchpro/bloc/animal/animal_photo_event.dart';
import 'package:photofetchpro/bloc/homepagebloc/homepage_bloc.dart';
import 'package:photofetchpro/bloc/homepagebloc/homepage_event.dart';
import 'package:photofetchpro/bloc/homepagebloc/homepage_state.dart';
import 'package:photofetchpro/bloc/nature/nature_photo_bloc.dart';
import 'package:photofetchpro/bloc/nature/nature_photo_event.dart';
import 'package:photofetchpro/bloc/people/people_photo_bloc.dart';
import 'package:photofetchpro/bloc/topphoto/top_photo_bloc.dart';
import 'package:photofetchpro/bloc/topphoto/top_photo_event.dart';
import 'package:photofetchpro/screen/all_photo_screen.dart';
import 'package:photofetchpro/widget/loadimage.dart';
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
                if (l == "Loading") {
                  return Leftsiderror(
                    titel: "All",
                    loadingstate: true,
                  );
                } else {
                  return Leftsiderror(
                    titel: "All",
                    loadingstate: false,
                  );
                }
              }, (r) {
                allphoto.clear();
                allphoto.addAll(r['photos']
                    .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                    .toList());
                return Imageviewlist(
                  allphoto: allphoto,
                  titel: "All",
                );
              }),
              state.gettopphoto.fold((l) {
                if (l == "Loading") {
                  return Leftsiderror(
                    titel: "Top",
                    loadingstate: true,
                  );
                } else {
                  return Leftsiderror(
                    titel: "Top",
                    loadingstate: false,
                  );
                }
              }, (r) {
                topphoto.clear();
                topphoto.addAll(r['photos']
                    .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                    .toList());
                return Imageviewlist(
                  allphoto: topphoto,
                  titel: "Top",
                );
              }),
              state.getnaturephoto.fold((l) {
                if (l == "Loading") {
                  return Leftsiderror(
                    titel: "Nature",
                    loadingstate: true,
                  );
                } else {
                  return Leftsiderror(
                    titel: "Nature",
                    loadingstate: false,
                  );
                }
              }, (r) {
                naturephoto.clear();
                naturephoto.addAll(r['photos']
                    .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                    .toList());
                return Imageviewlist(
                  allphoto: naturephoto,
                  titel: "Nature",
                );
              }),
              state.getanimalphoto.fold((l) {
                if (l == "Loading") {
                  return Leftsiderror(
                    titel: "Animal",
                    loadingstate: true,
                  );
                } else {
                  return Leftsiderror(
                    titel: "Animal",
                    loadingstate: false,
                  );
                }
              }, (r) {
                anlimalphoto.clear();
                anlimalphoto.addAll(r['photos']
                    .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                    .toList());
                return Imageviewlist(
                  allphoto: anlimalphoto,
                  titel: "Animal",
                );
              }),
              state.getpeoplephoto.fold((l) {
                if (l == "Loading") {
                  return Leftsiderror(
                    titel: "People",
                    loadingstate: true,
                  );
                } else {
                  return Leftsiderror(
                    titel: "People",
                    loadingstate: false,
                  );
                }
              }, (r) {
                peoplephoto.clear();
                peoplephoto.addAll(r['photos']
                    .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                    .toList());
                return Imageviewlist(
                  allphoto: peoplephoto,
                  titel: "People",
                );
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

class Imageviewlist extends StatelessWidget {
  const Imageviewlist({
    super.key,
    required this.allphoto,
    required this.titel,
  });
  final String titel;
  final List<Photo> allphoto;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
      width: double.infinity,
      height: 270,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 5),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.transparent),
                onPressed: () {
                  if (titel == "All") {
                    BlocProvider.of<AllPhotoBloc>(context)
                        .add(LoadAllPhotoEvent(1));
                  } else if (titel == "Top") {
                    BlocProvider.of<TopPhotoBloc>(context)
                        .add(LoadTopPhotoEvent(1));
                  } else if (titel == "Nature") {
                    BlocProvider.of<NaturePhotoBloc>(context)
                        .add(LoadAllNaturePhotoEvent(1));
                  } else if (titel == "Animal") {
                    BlocProvider.of<AnimalPhotoBloc>(context)
                        .add(LoadAllAnimalPhotoEvent(1));
                  } else if (titel == "People") {
                    BlocProvider.of<PeoplePhotoBloc>(context)
                        .add(LoadAllPeoplePhotoEvent(1));
                  }

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return AllPhotoScreen(titel);
                    },
                  ));
                },
                child: Navgationtoallphoto(
                  titel: titel,
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
  }
}

// ignore: must_be_immutable
class Leftsiderror extends StatelessWidget {
  Leftsiderror({super.key, this.titel = "", this.loadingstate = false});
  String titel;
  bool loadingstate;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,
        height: 270,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 5),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
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
                    titel: titel,
                  ),
                ),
              ),
            ),
            Center(
                child: loadingstate == false
                    ? ElevatedButton(
                        onPressed: () {
                          if (titel == "All") {
                            BlocProvider.of<Homebloc>(context)
                                .add(HomeAllPhotoEvent());
                          } else if (titel == "Top") {
                            BlocProvider.of<Homebloc>(context)
                                .add(HomeTopPhotoEvent());
                          } else if (titel == "Nature") {
                            BlocProvider.of<Homebloc>(context)
                                .add(HomeNaturePhotoEvent());
                          } else if (titel == "Animal") {
                            BlocProvider.of<Homebloc>(context)
                                .add(HomeAnimalPhotoEvent());
                          } else if (titel == "People") {
                            BlocProvider.of<Homebloc>(context)
                                .add(HomePeoplePhotoEvent());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text("retry"))
                    : const CircularProgressIndicator()),
          ],
        ),
      ),
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
