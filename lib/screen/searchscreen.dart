import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/bloc/search/search_bloc.dart';
import 'package:wallpaper/bloc/search/search_event.dart';
import 'package:wallpaper/bloc/search/search_state.dart';
import '../model/photo.dart';
import '../widget/loadimage.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController control = TextEditingController();
  List<Photo> wallpaper = [];
  int totalpage = 0;
  int courentpage = 0;
  String status = '';
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
                      onSubmitted: (value) {
                        BlocProvider.of<SearchBloc>(context)
                            .add(SearchEvent(control.text));
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
        body: BlocBuilder<SearchBloc, ISearchState>(builder: (context, state) {
          if (state is SearchState) {
            return Column(
              children: [
                Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: ListView.builder(
                      itemCount: state.totalpage,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<SearchBloc>(context)
                                .add(LoadAllSearchEventEvent(index + 1));
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: state.curentpage == index + 1
                                    ? Colors.green
                                    : const Color.fromARGB(114, 57, 57, 57),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(child: Text((index).toString())),
                          ),
                        );
                      },
                    )),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, mainAxisExtent: 220),
                      itemCount: state.allwallpaper.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return LoadeImage(state.allwallpaper[index]);
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ErrorSearchState) {
            return Center(
              child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<SearchBloc>(context)
                        .add(LoadAllSearchEventEvent(state.curentpage));
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text("retry")),
            );
          } else if (state is LoadSearchState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Icon(
                Icons.search,
                size: 30,
              ),
            );
          }
        }),
      ),
    );
  }
}
