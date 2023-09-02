import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:wallpaper/bloc/savephoto/save_photo_bloc.dart';
import 'package:wallpaper/bloc/savephoto/save_photo_event.dart';
import 'package:wallpaper/bloc/savephoto/save_photo_state.dart';
import 'package:wallpaper/screen/showphoto.dart';
import 'package:wallpaper/widget/loadimage.dart';

class SavePhotoScreen extends StatelessWidget {
  const SavePhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SavePhotoBloc, ISavePhotoState>(
        builder: (context, state) {
          if (state is SavePhotoState) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 220),
                    itemCount: state.photos.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return LoadeImage(state.photos[index]);
                    },
                  ),
                ),
              ],
            );
          } else if (state is LoadingSavePhotoState) {
            return CircularProgressIndicator();
          } else if (state is EmpetySavePhotoState) {
            return Center(
              child: Icon(
                Icons.archive_outlined,
                size: 40,
              ),
            );
          } else {
            return Center(
              child: Icon(Icons.bookmark),
            );
          }
        },
      ),
    );
  }
}
