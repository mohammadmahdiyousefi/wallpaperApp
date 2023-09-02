import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../model/photo.dart';

abstract class IPeoplePhotoDataSourc {
  Future<Map> getwallpaperdatasource();
  Future<Map> getalllwallpaperdatasource(int curentpage);
}

class PeoplePhotoDataSourc extends IPeoplePhotoDataSourc {
  final Dio _dio = locator.get();
  @override
  Future<Map> getwallpaperdatasource() async {
    try {
      var response = await _dio.get(
        "search",
        queryParameters: {
          "page": 1,
          "query": "People",
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
          "query": "People",
        },
      );
      return response.data;
    } on DioException catch (ex) {
      throw ex;
    }
  }
}
