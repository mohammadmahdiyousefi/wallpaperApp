import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/photo.dart';

Future<Widget?> downloadbottomshet(BuildContext context,
    DraggableScrollableController controller, Photo photo) {
  List<String> item = [
    "original",
    "large2x",
    "large",
    "medium",
    "small",
    "portrait",
    "landscape",
    "tiny",
  ];
  return showModalBottomSheet(
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DraggableScrollableSheet(
          controller: controller,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          initialChildSize: 0.6,
          expand: false,
          snap: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.5, bottom: 12.5),
                        child: Text('Download',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, top: 10, left: 50, right: 50),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  minimumSize: Size(200, 50),
                                  backgroundColor: Colors.green),
                              onPressed: () async {
                                if (photo.src!.landscape != null &&
                                    index == 6) {
                                  await launchUrl(
                                      Uri.parse(photo.src!.landscape!),
                                      mode: LaunchMode
                                          .externalNonBrowserApplication);
                                } else if (photo.src!.large != null &&
                                    index == 2) {
                                  await launchUrl(Uri.parse(photo.src!.large!),
                                      mode: LaunchMode
                                          .externalNonBrowserApplication);
                                } else if (photo.src!.large2x != null &&
                                    index == 1) {
                                  await launchUrl(
                                      Uri.parse(photo.src!.large2x!),
                                      mode: LaunchMode
                                          .externalNonBrowserApplication);
                                } else if (photo.src!.medium != null &&
                                    index == 3) {
                                  await launchUrl(Uri.parse(photo.src!.medium!),
                                      mode: LaunchMode
                                          .externalNonBrowserApplication);
                                } else if (photo.src!.original != null &&
                                    index == 0) {
                                  await launchUrl(
                                      Uri.parse(photo.src!.original!),
                                      mode: LaunchMode
                                          .externalNonBrowserApplication);
                                } else if (photo.src!.portrait != null &&
                                    index == 5) {
                                  await launchUrl(
                                      Uri.parse(photo.src!.portrait!),
                                      mode: LaunchMode
                                          .externalNonBrowserApplication);
                                } else if (photo.src!.small != null &&
                                    index == 4) {
                                  await launchUrl(Uri.parse(photo.src!.small!),
                                      mode: LaunchMode
                                          .externalNonBrowserApplication);
                                } else if (photo.src!.tiny != null &&
                                    index == 6) {
                                  await launchUrl(Uri.parse(photo.src!.tiny!),
                                      mode: LaunchMode
                                          .externalNonBrowserApplication);
                                } else {
                                  await launchUrl(
                                      Uri.parse(photo.src!.original!),
                                      mode: LaunchMode
                                          .externalNonBrowserApplication);
                                }
                              },
                              child: Text(
                                item[index],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
