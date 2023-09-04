import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/data/datasourc/naturephotodatasourc.dart';
import 'package:wallpaper/di/di.dart';

abstract class INathurePhotoRepository {
  Future<Either<String, Map>> getphotorepository();
  Future<Either<String, Map>> getallphotorepository(int courentpage);
}

class NathurePhotoRepository extends INathurePhotoRepository {
  final INathurePhotoDataSourc _datasourc = locator.get();
  @override
  Future<Either<String, Map>> getphotorepository() async {
    try {
      var response = await _datasourc.getphotodatasource();
      return right(response);
    } on DioException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, Map>> getallphotorepository(int courentpage) async {
    try {
      var response = await _datasourc.getalllphotodatasource(courentpage);
      return right(response);
    } on DioException catch (ex) {
      return left(ex.message!);
    }
  }
}
