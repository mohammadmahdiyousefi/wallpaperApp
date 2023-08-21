import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wallpaper/data/datasourc/allphotodatasourc.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  locator.registerSingleton<Dio>(Dio(BaseOptions(
    baseUrl: 'https://api.pexels.com/v1/',
  )));
  //datasource

  // locator.registerFactory<IAllPhotoDataSourc>(() => AllPhotoDataSourc());
}
