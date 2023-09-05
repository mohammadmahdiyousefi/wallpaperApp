import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallpaper/bloc/search/search_bloc.dart';
import 'package:wallpaper/bloc/search/search_event.dart';
import 'package:wallpaper/screen/all_photo_screen.dart';
import '../model/photo.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController control = TextEditingController();
  List<Photo> wallpaper = [];
  int totalpage = 0;
  int courentpage = 0;
  String status = '';
  List<String> trending = [
    "ai",
    "indian flag",
    "friendship",
    "stress",
    "indian army",
    "rose",
    "young model",
    "mahadev",
    "cute cat",
    "little models",
  ];
  var box = Hive.box("recentsearch");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 40,
                      width: 270,
                      child: Center(
                        child: TextField(
                          controller: control,
                          onChanged: (value) {},
                          onSubmitted: (value) {
                            BlocProvider.of<SearchBloc>(context)
                                .add(SearchEvent(control.text));
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return AllPhotoScreen(control.text);
                              },
                            ));
                          },
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              hintText: "search",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      )),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ValueListenableBuilder(
                      valueListenable: box.listenable(),
                      builder: (context, value, child) {
                        return Visibility(
                          visible: value.values.isEmpty ? false : true,
                          child: Container(
                            height: 90,
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 30),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Recent searches",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await box.clear();
                                      },
                                      child: const Text(
                                        "Clear all",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 52, 172, 196),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.values.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 20,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 0),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () async {
                                                  BlocProvider.of<SearchBloc>(
                                                          context)
                                                      .add(SearchEvent(value
                                                          .values
                                                          .toList()[index]));
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) {
                                                      return AllPhotoScreen(
                                                          value.values
                                                              .toList()[index]);
                                                    },
                                                  ));
                                                },
                                                child: Text(value.values
                                                    .toList()[index])),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await box.delete(value.values
                                                    .toList()[index]);
                                              },
                                              child: const Icon(
                                                Icons.cancel_rounded,
                                                size: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Suggested tags",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                            runSpacing: 10,
                            children: trending
                                .map((e) => Trendingitem(
                                      titel: e,
                                    ))
                                .toList()),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Colors",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          runSpacing: 10,
                          children: [
                            Colorwidget(
                              color: Colors.red,
                              titel: "red",
                            ),
                            Colorwidget(
                              color: Colors.pink.shade300,
                              titel: "pink",
                            ),
                            Colorwidget(
                              color: Colors.orange,
                              titel: "orange",
                            ),
                            Colorwidget(
                              color: Colors.yellow,
                              titel: "yellow",
                            ),
                            Colorwidget(
                              color: Colors.green,
                              titel: "green",
                            ),
                            Colorwidget(
                              color: Colors.blue,
                              titel: "blue",
                            ),
                            Colorwidget(
                              color: Colors.purple,
                              titel: "purple",
                            ),
                            Colorwidget(
                              color: Colors.brown,
                              titel: "brown",
                            ),
                            Colorwidget(
                              color: Colors.black,
                              titel: "black",
                            ),
                            Colorwidget(
                              color: Colors.grey,
                              titel: "grey",
                            ),
                            Colorwidget(
                              color: Colors.white,
                              titel: "white",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
    //       }
    //       }),
    //     ),
    //   );
  }
}

// ignore: must_be_immutable
class Trendingitem extends StatelessWidget {
  Trendingitem({
    super.key,
    this.titel = "",
  });
  String titel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<SearchBloc>(context).add(SearchEvent(titel));
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return AllPhotoScreen(titel);
          },
        ));
      },
      child: Container(
        height: 35,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(8)),
        child: Text(titel),
      ),
    );
  }
}

// ignore: must_be_immutable
class Colorwidget extends StatelessWidget {
  Colorwidget({
    super.key,
    this.color = Colors.red,
    this.titel = "",
  });
  Color color;
  String titel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<SearchBloc>(context).add(SearchEvent(titel));
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return AllPhotoScreen(titel);
          },
        ));
      },
      child: Container(
        height: 30,
        width: 30,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}
