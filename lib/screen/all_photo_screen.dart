import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
import 'package:wallpaper/bloc/topphoto/top_photo_bloc.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_state.dart';
import 'package:wallpaper/model/photo.dart';
import 'package:wallpaper/screen/showphoto.dart';

import '../bloc/animal/animal_photo_event.dart';
import '../bloc/nature/nature_photo_event.dart';
import '../bloc/people/people_photo_event.dart';
import '../bloc/topphoto/top_photo_event.dart';

class AllPhotoScreen extends StatelessWidget {
  AllPhotoScreen(this.status, {super.key});
  String status = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(status),
        ),
        body: status == "All"
            ? BlocBuilder<AllPhotoBloc, IAllPhotoState>(
                builder: (context, state) {
                if (state is AllPhotoState) {
                  return state.lodingsate
                      ? SpinKitFadingFour(
                          color: Colors.green,
                        )
                      : finishload(wallpaper: state.allwallpaper);
                } else if (state is ErrorAllPhotoState) {
                  return errorload("All");
                } else {
                  return lodinload();
                }
              })
            : status == "Nature"
                ? BlocBuilder<NaturePhotoBloc, INaturePhotoState>(
                    builder: (context, state) {
                    if (state is NaturePhotoState) {
                      return state.lodingsate
                          ? SpinKitFadingFour(
                              color: Colors.green,
                            )
                          : finishload(wallpaper: state.allwallpaper);
                    } else if (state is ErrorNaturePhotoState) {
                      return errorload("Nature");
                    } else {
                      return lodinload();
                    }
                  })
                : status == "Top"
                    ? BlocBuilder<TopPhotoBloc, ITopPhotoState>(
                        builder: (context, state) {
                        if (state is TopPhotoState) {
                          return state.lodingsate
                              ? SpinKitFadingFour(
                                  color: Colors.green,
                                )
                              : finishload(wallpaper: state.allwallpaper);
                        } else if (state is ErrorTopPhotoState) {
                          return errorload("Top");
                        } else {
                          return lodinload();
                        }
                      })
                    : status == "Animal"
                        ? BlocBuilder<AnimalPhotoBloc, IAnimalPhotoState>(
                            builder: (context, state) {
                            if (state is AnimalPhotoState) {
                              return state.lodingsate
                                  ? SpinKitFadingFour(
                                      color: Colors.green,
                                    )
                                  : finishload(wallpaper: state.allwallpaper);
                            } else if (state is ErrorAnimalPhotoState) {
                              return errorload("Animal");
                            } else {
                              return lodinload();
                            }
                          })
                        : status == "People"
                            ? BlocBuilder<PeoplePhotoBloc, IPeoplePhotoState>(
                                builder: (context, state) {
                                if (state is PeoplePhotoState) {
                                  return state.lodingsate
                                      ? SpinKitFadingFour(
                                          color: Colors.green,
                                        )
                                      : finishload(
                                          wallpaper: state.allwallpaper);
                                } else if (state is ErrorPeoplePhotoState) {
                                  return errorload("People");
                                } else {
                                  return lodinload();
                                }
                              })
                            : Container());
  }
}

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

class errorload extends StatelessWidget {
  errorload(
    this.status, {
    super.key,
  });
  String status = "";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            if (status == "All") {
              BlocProvider.of<AllPhotoBloc>(context).add(AllPhotoEvent());
            } else if (status == "Nature") {
              BlocProvider.of<NaturePhotoBloc>(context).add(NaturePhotoEvent());
            } else if (status == "Top") {
              BlocProvider.of<TopPhotoBloc>(context).add(TopPhotoEvent());
            } else if (status == "People") {
              BlocProvider.of<PeoplePhotoBloc>(context).add(PeoplePhotoEvent());
            } else if (status == "Animal") {
              BlocProvider.of<AnimalPhotoBloc>(context).add(AnimalPhotoEvent());
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

class finishload extends StatelessWidget {
  const finishload({
    super.key,
    required this.wallpaper,
  });

  final List<Photo> wallpaper;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 220),
            itemCount: wallpaper.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return ShowPhotoScreen(
                                image: wallpaper[index],
                              );
                            },
                          ));
                        },
                        child: SizedBox(
                            height: 200,
                            width: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: wallpaper[index].src!.medium!,
                                placeholder: (context, url) => ShimmerEffect(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: 200,
                                    width: 150,
                                    color: Colors.grey,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            )),
                      ),
                      Container(
                        width: 150,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(106, 0, 0, 0),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(children: [
                            SizedBox(
                                width: 60,
                                child: Text(
                                  wallpaper[index].photographer!,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Spacer(),
                            Icon(
                              Icons.download_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.bookmark_outline,
                              color: Colors.white,
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
