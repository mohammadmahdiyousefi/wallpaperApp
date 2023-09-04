import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class SetingScreen extends StatefulWidget {
  const SetingScreen({super.key});

  @override
  State<SetingScreen> createState() => _SetingScreenState();
}

class _SetingScreenState extends State<SetingScreen> {
  String titel = "High";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      const Divider(),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
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
                const Spacer(),
                Switch(
                  value: getthememode(),
                  onChanged: (value) {
                    changetheme();
                  },
                )
              ],
            )),
      ),
      const Divider(),
      Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Text(
              "Photo Quality",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  titel = value;
                });
              },
              shadowColor: Colors.transparent,
              position: PopupMenuPosition.under,
              child: Text(titel),
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    child: Text("High"),
                    value: "High",
                  ),
                  PopupMenuItem(
                    child: Text("medium"),
                    value: "medium",
                  ),
                  PopupMenuItem(
                    child: Text("Low"),
                    value: "Low",
                  )
                ];
              },
            ),
          ],
        ),
      ),
      const Divider(),
      const Spacer(),
      const Divider(),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                onTap: () async {
                  await launchUrl(
                      Uri.parse("https://github.com/mohammadmahdiyousefi"),
                      mode: LaunchMode.externalNonBrowserApplication);
                },
                child: const Image(
                  image: AssetImage("images/Github-PNG.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                onTap: () async {
                  await launchUrl(Uri.parse("https://t.me/photo_fetch_pro"),
                      mode: LaunchMode.externalNonBrowserApplication);
                },
                child: const Image(
                  image: AssetImage("images/tlegram.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                onTap: () async {},
                child: const Icon(Icons.share),
              ),
            )
          ])),
      const Row(
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
