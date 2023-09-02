import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class SetingScreen extends StatelessWidget {
  const SetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(10)),
        child: ElevatedButton(
            onPressed: () {
              changetheme();
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent),
            child: Row(
              children: [
                Text(
                  "Dark Theme",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Spacer(),
                Switch(
                  value: getthememode(),
                  onChanged: (value) {
                    changetheme();
                  },
                )
              ],
            )),
      ),
      Spacer(),
      Divider(),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                onTap: () async {
                  await launchUrl(
                      Uri.parse("https://github.com/mohammadmahdiyousefi"),
                      mode: LaunchMode.externalNonBrowserApplication);
                },
                child: Image(
                  image: AssetImage("images/Github-PNG.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                onTap: () async {
                  await launchUrl(Uri.parse("https://t.me/photo_fetch_pro"),
                      mode: LaunchMode.externalNonBrowserApplication);
                },
                child: Image(
                  image: AssetImage("images/tlegram.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                onTap: () async {},
                child: Icon(Icons.share),
              ),
            )
          ])),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Made with  "),
          Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          Text("  by Mohammad Mahdi"),
        ],
      )
    ])));
  }

  void changetheme() async {
    var box = Hive.box("theme");
    bool mode = box.get("mode", defaultValue: false);
    await box.put("mode", !mode);
  }

  bool getthememode() {
    var box = Hive.box("theme");
    bool mode = box.get("mode", defaultValue: false);
    return mode;
  }
}
