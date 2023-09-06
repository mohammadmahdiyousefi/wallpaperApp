import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:photofetchpro/model/photo.dart';
import '../bloc/savephoto/save_photo_bloc.dart';
import '../bloc/savephoto/save_photo_event.dart';
import '../widget/download_widget.dart';

// ignore: must_be_immutable
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
            child: const Icon(Icons.arrow_back_ios)),
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
                                    const Icon(Icons.error),
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
                                    child: const Icon(Icons.share),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          minimumSize: const Size(200, 40),
                                          backgroundColor: Colors.green),
                                      onPressed: () async {
                                        // await launchUrl(Uri.parse(image.src!.original!),
                                        //     mode: LaunchMode.externalNonBrowserApplication);
                                        downloadbottomshet(
                                            context, controller, widget.image);
                                      },
                                      child: const Text(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              margin: const EdgeInsets.symmetric(
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
                                      ? const Icon(Icons.keyboard_arrow_down)
                                      : const Icon(Icons.keyboard_arrow_left),
                                  const Text(
                                    "Info",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isvisble,
                            child: Container(
                                // height: 250,
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                margin: const EdgeInsets.symmetric(
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
                                          const Text("photographer : ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                          Text(widget.image.photographer!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text("photographerId : ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                              " ${widget.image.photographerId}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text("id : ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                          Text(widget.image.id.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text("height : ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                          Text(" ${widget.image.height}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text("width : ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                          Text(" ${widget.image.width}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text("avgColor : ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                          Text(" ${widget.image.avgColor}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(int.parse(
                                                    "ff${widget.image.avgColor!.substring(1)}",
                                                    radix: 16)),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("url : ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.66,
                                            child: SelectableText(
                                                " ${widget.image.url}",
                                                maxLines: 6,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
