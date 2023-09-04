import 'package:dio/dio.dart';
import '../../di/di.dart';

abstract class ISearchPhotoDataSourc {
  Future<Map> getphotodatasource(String titel);
  Future<Map> getalllphotodatasource(int curentpage);
}

class SearchPhotoDataSourc extends ISearchPhotoDataSourc {
  final Dio _dio = locator.get();
  String titel = "";
  @override
  // TODO: implement photo
  Future<Map> getphotodatasource(String titel) async {
    this.titel = titel;
    try {
      var response = await _dio.get(
        "search",
        queryParameters: {
          "page": 1,
          "query": titel,
        },
      );
      return response.data;
    } on DioException catch (ex) {
      throw ex;
    }
  }

  @override
  Future<Map> getalllphotodatasource(
    int curentpage,
  ) async {
    try {
      var response = await _dio.get(
        "search",
        queryParameters: {
          "page": curentpage,
          "query": titel,
        },
      );
      return response.data;
    } on DioException catch (ex) {
      throw ex;
    }
  }
}
