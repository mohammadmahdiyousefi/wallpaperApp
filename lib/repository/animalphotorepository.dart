import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/di/di.dart';
import '../data/datasourc/animalphotodatasourc.dart';

abstract class IAnimalPhotoRepository {
  Future<Either<String, Map>> getphotorepository();
  Future<Either<String, Map>> getallphotorepository(int courentpage);
}

class AnimalPhotoRepository extends IAnimalPhotoRepository {
  final IAnimalPhotoDataSourc _datasourc = locator.get();
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
