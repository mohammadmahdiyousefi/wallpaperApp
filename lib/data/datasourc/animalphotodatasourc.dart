import 'package:dio/dio.dart';
import '../../di/di.dart';

abstract class IAnimalPhotoDataSourc {
  Future<Map> getphotodatasource();
  Future<Map> getalllphotodatasource(int curentpage);
}

class AnimalPhotoDataSourc extends IAnimalPhotoDataSourc {
  final Dio _dio = locator.get();
  @override
  Future<Map> getphotodatasource() async {
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
  Future<Map> getalllphotodatasource(int curentpage) async {
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
