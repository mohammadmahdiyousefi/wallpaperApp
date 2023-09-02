import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_bloc.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_event.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_state.dart';
import 'package:wallpaper/bloc/animal/animal_photo_bloc.dart';
import 'package:wallpaper/bloc/animal/animal_photo_state.dart';
import 'package:wallpaper/bloc/nature/nature_photo_bloc.dart';
import 'package:wallpaper/bloc/nature/nature_photo_state.dart';
import 'package:wallpaper/bloc/people/people_photo_bloc.dart';
import 'package:wallpaper/bloc/people/people_photo_state.dart';
import 'package:wallpaper/bloc/search/search_bloc.dart';
import 'package:wallpaper/bloc/search/search_event.dart';
import 'package:wallpaper/bloc/search/search_state.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_bloc.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_state.dart';
import 'package:wallpaper/model/photo.dart';
import '../bloc/animal/animal_photo_event.dart';
import '../bloc/nature/nature_photo_event.dart';
import '../bloc/people/people_photo_event.dart';
import '../bloc/topphoto/top_photo_event.dart';
import '../widget/loadimage.dart';

// ignore: must_be_immutable
class AllPhotoScreen extends StatelessWidget {
  AllPhotoScreen(this.status, {super.key});
  String status = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(status),
        ),
        body: status == "All"
            ? BlocBuilder<AllPhotoBloc, IAllPhotoState>(
                builder: (context, state) {
                if (state is AllPhotoState) {
                  return Finishload(
                      wallpaper: state.allwallpaper,
                      courentpage: state.curentpage,
                      totalpage: state.totalpage,
                      status: "All");
                } else if (state is ErrorAllPhotoState) {
                  return errorload("All", state.curentpage);
                } else {
                  return const lodinload();
                }
              })
            : status == "Nature"
                ? BlocBuilder<NaturePhotoBloc, INaturePhotoState>(
                    builder: (context, state) {
                    if (state is NaturePhotoState) {
                      return Finishload(
                          wallpaper: state.allwallpaper,
                          courentpage: state.curentpage,
                          totalpage: state.totalpage,
                          status: "Nature");
                    } else if (state is ErrorNaturePhotoState) {
                      return errorload("Nature", state.curentpage);
                    } else {
                      return const lodinload();
                    }
                  })
                : status == "Top"
                    ? BlocBuilder<TopPhotoBloc, ITopPhotoState>(
                        builder: (context, state) {
                        if (state is TopPhotoState) {
                          return Finishload(
                            wallpaper: state.allwallpaper,
                            courentpage: state.curentpage,
                            totalpage: state.totalpage,
                            status: "Top",
                          );
                        } else if (state is ErrorTopPhotoState) {
                          return errorload("Top", state.curentpage);
                        } else {
                          return const lodinload();
                        }
                      })
                    : status == "Animal"
                        ? BlocBuilder<AnimalPhotoBloc, IAnimalPhotoState>(
                            builder: (context, state) {
                            if (state is AnimalPhotoState) {
                              return Finishload(
                                  wallpaper: state.allwallpaper,
                                  courentpage: state.curentpage,
                                  totalpage: state.totalpage,
                                  status: "Animal");
                            } else if (state is ErrorAnimalPhotoState) {
                              return errorload("Animal", state.curentpage);
                            } else {
                              return const lodinload();
                            }
                          })
                        : status == "People"
                            ? BlocBuilder<PeoplePhotoBloc, IPeoplePhotoState>(
                                builder: (context, state) {
                                if (state is PeoplePhotoState) {
                                  return Finishload(
                                      wallpaper: state.allwallpaper,
                                      courentpage: state.curentpage,
                                      totalpage: state.totalpage,
                                      status: "People");
                                } else if (state is ErrorPeoplePhotoState) {
                                  return errorload("People", state.curentpage);
                                } else {
                                  return const lodinload();
                                }
                              })
                            : status == "Allresult"
                                ? BlocBuilder<SearchBloc, ISearchState>(
                                    builder: (context, state) {
                                    if (state is SearchState) {
                                      return Finishload(
                                        wallpaper: state.allwallpaper,
                                        courentpage: state.curentpage,
                                        totalpage: state.totalpage,
                                        status: "Allresult",
                                      );
                                    } else if (state is ErrorSearchState) {
                                      return errorload(
                                          "search", state.curentpage);
                                    } else {
                                      return const lodinload();
                                    }
                                  })
                                : Container());
  }
}

// ignore: camel_case_types
class lodinload extends StatelessWidget {
  const lodinload({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 220),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                      height: 200,
                      width: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ShimmerEffect(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                            height: 200,
                            width: 150,
                            color: Colors.grey,
                          ),
                        ),
                      )),
                  Container(
                    width: 150,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(106, 0, 0, 0),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(children: [
                        ShimmerEffect(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                            height: 10,
                            width: 60,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.download_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Icon(
                          Icons.bookmark_outline,
                          color: Colors.white,
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class errorload extends StatelessWidget {
  errorload(
    this.status,
    this.index, {
    super.key,
  });
  String status = "";
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            if (status == "All") {
              BlocProvider.of<AllPhotoBloc>(context)
                  .add(LoadAllPhotoEvent(index));
            } else if (status == "Nature") {
              BlocProvider.of<NaturePhotoBloc>(context)
                  .add(LoadAllNaturePhotoEvent(index));
            } else if (status == "Top") {
              BlocProvider.of<TopPhotoBloc>(context)
                  .add(LoadTopPhotoEvent(index));
            } else if (status == "People") {
              BlocProvider.of<PeoplePhotoBloc>(context)
                  .add(LoadAllPeoplePhotoEvent(index));
            } else if (status == "Animal") {
              BlocProvider.of<AnimalPhotoBloc>(context)
                  .add(LoadAllAnimalPhotoEvent(index));
            }
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Text("retry")),
    );
  }
}

// ignore: must_be_immutable
class Finishload extends StatelessWidget {
  Finishload(
      {super.key,
      required this.wallpaper,
      required this.courentpage,
      required this.totalpage,
      required this.status});
  final List<Photo> wallpaper;
  int totalpage;
  int courentpage;
  String status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(

                //  color: Colors.green.shade200.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5)),
            child: ListView.builder(
              itemCount: totalpage,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (status == "All") {
                      BlocProvider.of<AllPhotoBloc>(context)
                          .add(LoadAllPhotoEvent(index + 1));
                    } else if (status == "Nature") {
                      BlocProvider.of<NaturePhotoBloc>(context)
                          .add(LoadAllNaturePhotoEvent(index + 1));
                    } else if (status == "Top") {
                      BlocProvider.of<TopPhotoBloc>(context)
                          .add(LoadTopPhotoEvent(index + 1));
                    } else if (status == "People") {
                      BlocProvider.of<PeoplePhotoBloc>(context)
                          .add(LoadAllPeoplePhotoEvent(index + 1));
                    } else if (status == "Animal") {
                      BlocProvider.of<AnimalPhotoBloc>(context)
                          .add(LoadAllAnimalPhotoEvent(index + 1));
                    } else if (status == "Allresult") {
                      BlocProvider.of<SearchBloc>(context)
                          .add(LoadAllSearchEventEvent(index + 1));
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: courentpage == index + 1
                            ? Colors.green
                            : const Color.fromARGB(114, 57, 57, 57),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(child: Text((index).toString())),
                  ),
                );
              },
            )),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 220),
            itemCount: wallpaper.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return LoadeImage(wallpaper[index]);
            },
          ),
        ),
      ],
    );
  }
}
