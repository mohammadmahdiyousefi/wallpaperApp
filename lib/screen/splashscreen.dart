import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_bloc.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_event.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool conection = true;
  Widget loading = const SpinKitThreeInOut(color: Color(0xff81BFA1));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkintenet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage("images/logo.png"),
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            conection == true
                ? const SpinKitThreeInOut(color: Color(0xff81BFA1))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                    ),
                    onPressed: () {
                      checkintenet();
                    },
                    child: const Text("retry"),
                  )
            // SizedBox(
            //   height: 30,
            //   width: 80,
            //   child: BlocBuilder<SplashBloc, ISplashState>(
            //     builder: (context, state) {
            //       if (state is ConectedSplashState) {
            //         checkintenet();
            //       } else if (state is FaildconectionState) {
            //         return ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10)),
            //             elevation: 5,
            //           ),
            //           onPressed: () {
            //             BlocProvider.of<SplashBloc>(context).add(SplashEvent());
            //           },
            //           child: const Text("retry"),
            //         );
            //       }
            //       return loading;
            //     },
            //   ),
            // )
          ]),
    );
  }

  void checkintenet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    setState(() {
      if (result == true) {
        conection = true;
        BlocProvider.of<Homebloc>(context).add(HomeEvent());
        Future.delayed(const Duration(seconds: 6), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      } else {
        conection = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: const Color.fromARGB(132, 96, 94, 94),
            elevation: 0,
            content: Text(
              "Pleas Check your Internet Conection",
              style: Theme.of(context).textTheme.labelMedium,
            )));
      }
    });
  }
}
