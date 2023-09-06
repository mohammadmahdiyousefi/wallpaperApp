import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:photofetchpro/data/datasourc/allphotodatasourc.dart';
import 'package:photofetchpro/data/datasourc/animalphotodatasourc.dart';
import 'package:photofetchpro/data/datasourc/naturephotodatasourc.dart';
import 'package:photofetchpro/data/datasourc/peoplephotodatasouirc.dart';
import 'package:photofetchpro/data/datasourc/searchdatasourc.dart';
import 'package:photofetchpro/data/datasourc/topphotodatasourc.dart';
import 'package:photofetchpro/repository/allphotorepository.dart';
import 'package:photofetchpro/repository/animalphotorepository.dart';
import 'package:photofetchpro/repository/nathurephotorepository.dart';
import 'package:photofetchpro/repository/peoplephotorepository.dart';
import 'package:photofetchpro/repository/searchrepository.dart';
import 'package:photofetchpro/repository/topphotorepository.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  locator.registerSingleton<Dio>(Dio(
      BaseOptions(baseUrl: 'https://api.pexels.com/v1/', headers: {
    "Authorization": "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
  })));

  //datasource

  locator.registerFactory<IAllPhotoDataSourc>(() => AllPhotoDataSourc());
  locator.registerFactory<ITopPhotoDataSourc>(() => TopPhotoDataSourc());
  locator
      .registerFactory<INathurePhotoDataSourc>(() => NathurePhotoDataSourc());
  locator.registerFactory<IAnimalPhotoDataSourc>(() => AnimalPhotoDataSourc());
  locator.registerFactory<IPeoplePhotoDataSourc>(() => PeoplePhotoDataSourc());
  locator.registerFactory<ISearchPhotoDataSourc>(() => SearchPhotoDataSourc());

  // locator.registerFactory<IAllPhotoDataSourc>(() => AllPhotoDataSourc());

  //repository

  locator.registerFactory<IAllPhotoRepository>(() => AllPhotoRepository());
  locator.registerFactory<ITopPhotoRepository>(() => TopPhotoRepository());
  locator
      .registerFactory<INathurePhotoRepository>(() => NathurePhotoRepository());
  locator
      .registerFactory<IAnimalPhotoRepository>(() => AnimalPhotoRepository());
  locator
      .registerFactory<IPeoplePhotoRepository>(() => PeoplePhotoRepository());
  locator
      .registerFactory<ISearchPhotoRepository>(() => SearchPhotoRepository());
}
