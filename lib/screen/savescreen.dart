import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photofetchpro/bloc/savephoto/save_photo_bloc.dart';
import 'package:photofetchpro/bloc/savephoto/save_photo_state.dart';
import 'package:photofetchpro/widget/loadimage.dart';

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
            return const CircularProgressIndicator();
          } else if (state is EmpetySavePhotoState) {
            return const Center(
              child: Icon(
                Icons.archive_outlined,
                size: 40,
              ),
            );
          } else {
            return const Center(
              child: Icon(Icons.bookmark),
            );
          }
        },
      ),
    );
  }
}
