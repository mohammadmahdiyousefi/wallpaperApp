import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../model/photo.dart';

abstract class IAnimalPhotoDataSourc {
  Future<Map> getwallpaperdatasource();
  Future<Map> getalllwallpaperdatasource(int curentpage);
}

class AnimalPhotoDataSourc extends IAnimalPhotoDataSourc {
  final Dio _dio = locator.get();
  @override
  Future<Map> getwallpaperdatasource() async {
    try {
      var response = await _dio.get(
        "search",
        queryParameters: {
          "page": 1,
          "query": "Animal",
        },
      );
      return response.data;
    } on DioException catch (ex) {
      throw ex;
    }
  }

  @override
  Future<Map> getalllwallpaperdatasource(int curentpage) async {
    try {
      var response = await _dio.get(
        "search",
        queryParameters: {
          "page": curentpage,
          "query": "Animal",
        },
      );
      return response.data;
    } on DioException catch (ex) {
      throw ex;
    }
  }
}
