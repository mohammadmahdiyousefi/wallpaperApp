import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/data/datasourc/allphotodatasourc.dart';
import 'package:wallpaper/data/datasourc/naturephotodatasourc.dart';
import 'package:wallpaper/di/di.dart';
import 'package:wallpaper/model/photo.dart';

import '../data/datasourc/peoplephotodatasouirc.dart';

abstract class IPeoplePhotoRepository {
  Future<Either<String, Map>> getphotorepository();
  Future<Either<String, Map>> getallphotorepository(int courentpage);
}

class PeoplePhotoRepository extends IPeoplePhotoRepository {
  final IPeoplePhotoDataSourc _datasourc = locator.get();
  @override
  Future<Either<String, Map>> getphotorepository() async {
    try {
      var response = await _datasourc.getwallpaperdatasource();
      return right(response);
    } on DioException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, Map>> getallphotorepository(int courentpage) async {
    try {
      var response = await _datasourc.getalllwallpaperdatasource(courentpage);
      return right(response);
    } on DioException catch (ex) {
      return left(ex.message!);
    }
  }
}
