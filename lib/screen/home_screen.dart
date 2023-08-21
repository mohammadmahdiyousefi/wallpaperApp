import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_bloc.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_event.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_state.dart';
import 'package:wallpaper/bloc/animal/animal_photo_bloc.dart';
import 'package:wallpaper/bloc/animal/animal_photo_event.dart';
import 'package:wallpaper/bloc/animal/animal_photo_state.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_bloc.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_state.dart';
import 'package:wallpaper/bloc/nature/nature_photo_bloc.dart';
import 'package:wallpaper/bloc/nature/nature_photo_event.dart';
import 'package:wallpaper/bloc/nature/nature_photo_state.dart';
import 'package:wallpaper/bloc/people/people_photo_bloc.dart';
import 'package:wallpaper/bloc/people/people_photo_state.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_bloc.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_event.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_state.dart';
import 'package:wallpaper/screen/all_photo_screen.dart';
import 'package:wallpaper/screen/showphoto.dart';

import '../bloc/people/people_photo_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: 270,
              child: BlocBuilder<AllPhotoBloc, IAllPhotoState>(
                  builder: (context, state) {
                if (state is AllPhotoState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, top: 10, bottom: 10, right: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            BlocProvider.of<AllPhotoBloc>(context)
                                .add(LoadAllPhotoEvent());
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return AllPhotoScreen("All");
                              },
                            ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "All ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.wallpaper.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return ShowPhotoScreen(
                                                image: state.wallpaper[index],
                                              );
                                            },
                                          ));
                                        },
                                        child: SizedBox(
                                            height: 200,
                                            width: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: state.wallpaper[index]
                                                    .src!.medium!,
                                                placeholder: (context, url) =>
                                                    ShimmerEffect(
                                                  baseColor: Colors.grey,
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                    height: 200,
                                                    width: 150,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            )),
                                      ),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(children: [
                                            SizedBox(
                                                width: 60,
                                                child: Text(
                                                  state.wallpaper[index]
                                                      .photographer!,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
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
                        ),
                      ),
                    ],
                  );
                } else if (state is ErrorAllPhotoState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 25, top: 10, bottom: 10, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "All ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<AllPhotoBloc>(context)
                                  .add(AllPhotoEvent());
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
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 25, top: 10, bottom: 10, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "All ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
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
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: 270,
              child: BlocBuilder<TopPhotoBloc, ITopPhotoState>(
                  builder: (context, state) {
                if (state is TopPhotoState) {
                  return Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 10, bottom: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            BlocProvider.of<TopPhotoBloc>(context)
                                .add(LoadTopPhotoEvent());

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return AllPhotoScreen("Top");
                              },
                            ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "top ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.wallpaper.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return ShowPhotoScreen(
                                                image: state.wallpaper[index],
                                              );
                                            },
                                          ));
                                        },
                                        child: SizedBox(
                                            height: 200,
                                            width: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: state.wallpaper[index]
                                                    .src!.medium!,
                                                placeholder: (context, url) =>
                                                    ShimmerEffect(
                                                  baseColor: Colors.grey,
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                    height: 200,
                                                    width: 150,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            )),
                                      ),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(children: [
                                            SizedBox(
                                                width: 60,
                                                child: Text(
                                                  state.wallpaper[index]
                                                      .photographer!,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
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
                        ),
                      ),
                    ],
                  );
                } else if (state is ErrorTopPhotoState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, top: 10, bottom: 25, right: 25),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "top ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<TopPhotoBloc>(context)
                                  .add(TopPhotoEvent());
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
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, top: 10, bottom: 5, right: 25),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "top ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
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
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: 270,
              child: BlocBuilder<NaturePhotoBloc, INaturePhotoState>(
                  builder: (context, state) {
                if (state is NaturePhotoState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          top: 10,
                          bottom: 5,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            BlocProvider.of<NaturePhotoBloc>(context)
                                .add(LoadAllNaturePhotoEvent());

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return AllPhotoScreen("Nature");
                              },
                            ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nature",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.wallpaper.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 15),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return ShowPhotoScreen(
                                                image: state.wallpaper[index],
                                              );
                                            },
                                          ));
                                        },
                                        child: SizedBox(
                                            height: 200,
                                            width: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: state.wallpaper[index]
                                                    .src!.medium!,
                                                placeholder: (context, url) =>
                                                    ShimmerEffect(
                                                  baseColor: Colors.grey,
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                    height: 200,
                                                    width: 150,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(children: [
                                            SizedBox(
                                                width: 60,
                                                child: Text(
                                                  state.wallpaper[index]
                                                      .photographer!,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, top: 10, bottom: 5, right: 25),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nature",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: ShimmerEffect(
                                              baseColor: Colors.grey,
                                              highlightColor: Colors.white,
                                              child: Container(
                                                height: 200,
                                                width: 150,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            //  Image.network(
                                            //                         state.wallpaper[index].src!.medium!,
                                            //                         fit: BoxFit.cover,
                                            //                       ),
                                          )),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
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
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: 270,
              child: BlocBuilder<AnimalPhotoBloc, IAnimalPhotoState>(
                  builder: (context, state) {
                if (state is AnimalPhotoState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, top: 10, bottom: 10, right: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            BlocProvider.of<AnimalPhotoBloc>(context)
                                .add(LoadAllAnimalPhotoEvent());
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return AllPhotoScreen("Animal");
                              },
                            ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Animal ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.wallpaper.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return ShowPhotoScreen(
                                                image: state.wallpaper[index],
                                              );
                                            },
                                          ));
                                        },
                                        child: SizedBox(
                                            height: 200,
                                            width: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: state.wallpaper[index]
                                                    .src!.medium!,
                                                placeholder: (context, url) =>
                                                    ShimmerEffect(
                                                  baseColor: Colors.grey,
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                    height: 200,
                                                    width: 150,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            )),
                                      ),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(children: [
                                            SizedBox(
                                                width: 60,
                                                child: Text(
                                                  state.wallpaper[index]
                                                      .photographer!,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
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
                        ),
                      ),
                    ],
                  );
                } else if (state is ErrorAllPhotoState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 25, top: 10, bottom: 10, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Animal ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<AllPhotoBloc>(context)
                                  .add(AllPhotoEvent());
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
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 25, top: 10, bottom: 10, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Animal ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
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
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: 270,
              child: BlocBuilder<PeoplePhotoBloc, IPeoplePhotoState>(
                  builder: (context, state) {
                if (state is PeoplePhotoState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, top: 10, bottom: 10, right: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            BlocProvider.of<PeoplePhotoBloc>(context)
                                .add(LoadAllPeoplePhotoEvent());
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return AllPhotoScreen("People");
                              },
                            ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "People ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.wallpaper.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return ShowPhotoScreen(
                                                image: state.wallpaper[index],
                                              );
                                            },
                                          ));
                                        },
                                        child: SizedBox(
                                            height: 200,
                                            width: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: state.wallpaper[index]
                                                    .src!.medium!,
                                                placeholder: (context, url) =>
                                                    ShimmerEffect(
                                                  baseColor: Colors.grey,
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                    height: 200,
                                                    width: 150,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            )),
                                      ),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(children: [
                                            SizedBox(
                                                width: 60,
                                                child: Text(
                                                  state.wallpaper[index]
                                                      .photographer!,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
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
                        ),
                      ),
                    ],
                  );
                } else if (state is ErrorAllPhotoState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 25, top: 10, bottom: 10, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "People ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<AllPhotoBloc>(context)
                                  .add(AllPhotoEvent());
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
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 25, top: 10, bottom: 10, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "People ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
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
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
        ]),
      ),
    );
  }
}
