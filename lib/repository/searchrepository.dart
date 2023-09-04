import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/di/di.dart';
import '../data/datasourc/searchdatasourc.dart';

abstract class ISearchPhotoRepository {
  Future<Either<String, Map>> getphotorepository(String titel);
  Future<Either<String, Map>> getallphotorepository(int courentpage);
}

class SearchPhotoRepository extends ISearchPhotoRepository {
  final ISearchPhotoDataSourc _datasourc = locator.get();
  @override
  Future<Either<String, Map>> getphotorepository(String titel) async {
    try {
      var response = await _datasourc.getphotodatasource(titel);
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
