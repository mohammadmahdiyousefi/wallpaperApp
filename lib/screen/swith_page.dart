import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/bloc/savephoto/save_photo_bloc.dart';
import 'package:wallpaper/bloc/savephoto/save_photo_event.dart';
import 'package:wallpaper/screen/home_screen.dart';
import 'package:wallpaper/screen/savescreen.dart';
import 'package:wallpaper/screen/searchscreen.dart';
import 'package:wallpaper/screen/seting_screen.dart';

class SwithPage extends StatefulWidget {
  const SwithPage({super.key});

  @override
  State<SwithPage> createState() => _SwithPageState();
}

class _SwithPageState extends State<SwithPage> {
  List<Widget> page = [
    const SetingScreen(),
    SearchScreen(),
    HomePage(),
    const SavePhotoScreen()
  ];
  int index = 2;
  int backButtonPressedCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // تعداد دفعات فشرده شدن دکمه بازگشت
    return WillPopScope(
      onWillPop: () async {
        // این تابع هنگامی که دکمه بازگشت فشرده می‌شود فراخوانی می‌شود
        // در اینجا می‌توانید تصمیم بگیرید که آیا می‌خواهید از برنامه خارج شوید یا صرفا به صفحه قبلی برگردید
        if (backButtonPressedCount < 1) {
          setState(() {
            // اگر برای اولین بار دکمه بازگشت فشرده شود، تعداد را افزایش دهید
            backButtonPressedCount++;
            toastmasseage();
            // اگر دکمه بازگشت دومین بار فشرده شود، از برنامه خارج شوید
            Future.delayed(const Duration(seconds: 2), () {
              // انتظار 1 ثانیه برای دکمه بازگشت دومین بار
              backButtonPressedCount = 0;
            }); // بازنشانی تعداد برای مرحله بعدی
          });
          return false;
        } else {
          return true; // از برنامه خارج شود
        }
      },
      child: Scaffold(
        body: IndexedStack(index: index, children: page),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) async {
              setState(() {
                index = value;
              });
              if (value == 3) {
                BlocProvider.of<SavePhotoBloc>(context)
                    .add(LoadSavePhotoEvent());
              }
            },
            selectedItemColor: Colors.green,
            unselectedItemColor: Theme.of(context).colorScheme.onBackground,
            currentIndex: index,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: "Settings"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark), label: "Saved"),
            ]),
      ),
    );
  }

  void toastmasseage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        elevation: 0,
        duration: const Duration(seconds: 1),
        content: Text(
          "double tap to exit",
          style: Theme.of(context).textTheme.labelMedium,
        )));
  }
}
