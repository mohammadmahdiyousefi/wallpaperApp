import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wallpaper/bloc/splashbloc/splash_event.dart';
import 'package:wallpaper/bloc/splashbloc/splash_state.dart';

class SplashBloc extends Bloc<ISplashEvent, ISplashState> {
  SplashBloc() : super(ConectedSplashState()) {
    on<SplashEvent>((event, emit) async {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        emit(ConectedSplashState());
      } else {
        emit(FaildconectionState());
      }
    });
  }
}
