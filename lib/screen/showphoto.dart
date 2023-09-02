import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wallpaper/model/photo.dart';

import '../bloc/savephoto/save_photo_bloc.dart';
import '../bloc/savephoto/save_photo_event.dart';
import '../bloc/savephoto/save_photo_state.dart';
import '../widget/download_widget.dart';
import '../widget/photo_info.dart';

class ShowPhotoScreen extends StatefulWidget {
  ShowPhotoScreen({super.key, required this.image});
  Photo image;

  @override
  State<ShowPhotoScreen> createState() => _ShowPhotoScreenState();
}

class _ShowPhotoScreenState extends State<ShowPhotoScreen> {
  var box = Hive.box("photo");
  bool isvisble = false;
  DraggableScrollableController controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.image.src!.large!,
                                placeholder: (context, url) => ShimmerEffect(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    width:
                                        double.parse('${widget.image.width}'),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    color: Colors.grey,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await Share.shareUri(Uri.parse(
                                          widget.image.src!.original!));
                                    },
                                    child: Icon(Icons.share),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          minimumSize: Size(200, 40),
                                          backgroundColor: Colors.green),
                                      onPressed: () async {
                                        // await launchUrl(Uri.parse(image.src!.original!),
                                        //     mode: LaunchMode.externalNonBrowserApplication);
                                        downloadbottomshet(
                                            context, controller, widget.image);
                                      },
                                      child: Text(
                                        "Download",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<SavePhotoBloc>(context)
                                        .add(SavePhotoEvent(widget.image));
                                  },
                                  child: ValueListenableBuilder(
                                      valueListenable: box.listenable(),
                                      builder: (context, value, child) {
                                        return Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondaryContainer,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Icon(
                                            value.keys.contains(widget.image.id)
                                                ? Icons.bookmark
                                                : Icons.bookmark_outline,
                                            size: 30,
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isvisble = !isvisble;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  isvisble == true
                                      ? Icon(Icons.keyboard_arrow_down)
                                      : Icon(Icons.keyboard_arrow_left),
                                  Text("Info")
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isvisble,
                            child: Container(
                                // height: 250,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "photographer : ",
                                          ),
                                          Text(
                                            widget.image.photographer!,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "photographerId : ",
                                          ),
                                          Text(
                                            " ${widget.image.photographerId}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "height : ",
                                          ),
                                          Text(
                                            " ${widget.image.height}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "width : ",
                                          ),
                                          Text(
                                            " ${widget.image.width}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "url : ",
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: SelectableText(
                                              " ${widget.image.url}",
                                              maxLines: 6,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    ))),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(8)),
            //           minimumSize: Size(200, 50),
            //           backgroundColor: Colors.green),
            //       onPressed: () async {
            //         // await launchUrl(Uri.parse(image.src!.original!),
            //         //     mode: LaunchMode.externalNonBrowserApplication);
            //         downloadbottomshet(context, controller, widget.image);
            //       },
            //       child: Text(
            //         "Download",
            //         style: TextStyle(color: Colors.white, fontSize: 18),
            //       )),
            // ),
          ],
        ),
      ),
    );
  }
}
