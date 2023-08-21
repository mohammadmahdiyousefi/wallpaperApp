import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wallpaper/model/photo.dart';

class ShowPhotoScreen extends StatelessWidget {
  ShowPhotoScreen({super.key, required this.image});
  Photo image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: image.src!.original!,
                              placeholder: (context, url) => ShimmerEffect(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  width: double.parse('${image.width}'),
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
                              horizontal: 40, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                image.photographer!,
                                style: TextStyle(fontSize: 23),
                              ),
                              Icon(
                                Icons.bookmark_outline,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.green),
                onPressed: () async {
                  await launchUrl(Uri.parse(image.src!.original!),
                      mode: LaunchMode.externalNonBrowserApplication);
                },
                child: Text(
                  "Download",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          ),
        ],
      ),
    );
  }
}
