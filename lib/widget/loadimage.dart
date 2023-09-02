import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:wallpaper/model/photo.dart';
import '../bloc/savephoto/save_photo_bloc.dart';
import '../bloc/savephoto/save_photo_event.dart';
import '../screen/showphoto.dart';
import 'download_widget.dart';

// ignore: must_be_immutable
class LoadeImage extends StatelessWidget {
  LoadeImage(this.image, {super.key});
  Photo image;
  var box = Hive.box("photo");
  DraggableScrollableController controller = DraggableScrollableController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(children: [
          Stack(alignment: Alignment.bottomCenter, children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ShowPhotoScreen(
                      image: image,
                    );
                  },
                ));
              },
              child: SizedBox(
                  height: 200,
                  width: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: image.src!.medium!,
                      placeholder: (context, url) => ShimmerEffect(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 200,
                          width: 160,
                          color: Colors.grey,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )),
            ),
            Container(
                width: 160,
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
                    SizedBox(
                        width: 60,
                        child: Text(
                          image.photographer!,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        downloadbottomshet(context, controller, image);
                      },
                      child: const Icon(
                        Icons.download_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("sdfsdfsdfdsfsdfsdfsdf");
                        BlocProvider.of<SavePhotoBloc>(context)
                            .add(SavePhotoEvent(image));
                      },
                      child: ValueListenableBuilder(
                          valueListenable: box.listenable(),
                          builder: (context, value, child) {
                            return Icon(
                                value.keys.contains(image.id)
                                    ? Icons.bookmark
                                    : Icons.bookmark_outline,
                                color: Colors.white);
                          }),
                    ),
                  ]),
                ))
          ])
        ]));
  }
}
