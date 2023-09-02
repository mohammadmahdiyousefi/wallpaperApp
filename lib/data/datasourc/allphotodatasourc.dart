import 'package:dio/dio.dart';
import '../../di/di.dart';

abstract class IAllPhotoDataSourc {
  Future<Map> getwallpaperdatasource();
  Future<Map> getalllwallpaperdatasource(int curentpage);
}

class AllPhotoDataSourc extends IAllPhotoDataSourc {
  final Dio _dio = locator.get();
  @override
  Future<Map> getwallpaperdatasource() async {
    // TODO: implement wallpaper
    try {
      var response = await _dio.get(
        "curated",
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
  Future<Map> getalllwallpaperdatasource(int curentpage) async {
    try {
      var response = await _dio.get(
        "curated",
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
