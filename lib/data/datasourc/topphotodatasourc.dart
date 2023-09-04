import 'package:dio/dio.dart';
import '../../di/di.dart';

abstract class ITopPhotoDataSourc {
  Future<Map> getphotodatasource();
  Future<Map> getalllphotodatasource(int curentpage);
}

class TopPhotoDataSourc extends ITopPhotoDataSourc {
  final Dio _dio = locator.get();
  @override
  Future<Map> getphotodatasource() async {
    // TODO: implement photo
    try {
      var response = await _dio.get(
        "popular",
        queryParameters: {
          "page": 1,
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
        "popular",
        queryParameters: {
          "page": curentpage,
        },
      );
      return response.data;
    } on DioException catch (ex) {
      throw ex;
    }
  }
}
