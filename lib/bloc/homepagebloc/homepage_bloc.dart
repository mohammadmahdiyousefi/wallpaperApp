import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_event.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_state.dart';

import '../../di/di.dart';
import '../../model/photo.dart';

class Homebloc extends Bloc<IHomeEvent, IHomeState> {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://api.pexels.com/v1/"));
  List<Photo> allwallpaper = [];
  List<Photo> topwallpaper = [];
  List<Photo> junglewallpaper = [];

  Homebloc() : super(LoadHomeState()) {
    on<HomeEvent>((event, emit) async {
      emit(LoadHomeState());
      try {
        await getallwallpaper();
        emit(HomeState(allwallpaper, topwallpaper, junglewallpaper));
        await gettopwallpaper();
        emit(HomeState(allwallpaper, topwallpaper, junglewallpaper));
        await getjunglewallpaper();
        emit(HomeState(allwallpaper, topwallpaper, junglewallpaper));
      } catch (ex) {
        print("error error error error ");
      }
    });
  }
  Future<void> gettopwallpaper() async {
    try {
      var response = await _dio.get("popular",
          options: Options(headers: {
            "Authorization":
                "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
          }));
      if (response.statusCode == 200) {
        int curentpage = response.data['page'];
        int totalpage = response.data['per_page'];
        try {
          response = await _dio.get("popular",
              queryParameters: {"page": 1, "per_page": totalpage},
              options: Options(headers: {
                "Authorization":
                    "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
              }));
          if (response.statusCode == 200) {
            topwallpaper.addAll(response.data['photos']
                .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                .toList());
          } else {}
        } on DioException catch (ex) {
          print(' secound Error fetching photos: ${ex.message}');
          print('Error fetching photos: ${ex.message}');
        }
      }
    } on DioException catch (ex) {
      print(' first Error fetching photos: ${ex.message}');
      print('Error fetching photos: ${ex.message}');
    }
  }

  Future<void> getallwallpaper() async {
    try {
      var response = await _dio.get("curated",
          options: Options(headers: {
            "Authorization":
                "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
          }));
      if (response.statusCode == 200) {
        int curentpage = response.data['page'];
        int totalpage = response.data['per_page'];
        try {
          response = await _dio.get("curated",
              queryParameters: {"page": 1, "per_page": totalpage},
              options: Options(headers: {
                "Authorization":
                    "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
              }));
          if (response.statusCode == 200) {
            allwallpaper.addAll(response.data['photos']
                .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                .toList());
          } else {}
        } on DioException catch (ex) {
          print(' secound Error fetching photos: ${ex.message}');
          print('Error fetching photos: ${ex.message}');
        }
      }
    } on DioException catch (ex) {
      print(' first Error fetching photos: ${ex.message}');
      print('Error fetching photos: ${ex.message}');
    }
  }

  Future<void> getjunglewallpaper() async {
    try {
      var response = await _dio.get("search",
          queryParameters: {
            "query": "Nature",
          },
          options: Options(headers: {
            "Authorization":
                "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
          }));
      if (response.statusCode == 200) {
        int curentpage = response.data['page'];
        int totalpage = response.data['per_page'];
        try {
          response = await _dio.get("search",
              queryParameters: {
                "query": "Nature",
                "page": 1,
                "per_page": totalpage,
              },
              options: Options(headers: {
                "Authorization":
                    "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
              }));
          if (response.statusCode == 200) {
            junglewallpaper.addAll(response.data['photos']
                .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                .toList());
          } else {}
        } on DioException catch (ex) {
          print(' secound Error fetching photos: ${ex.message}');
          print('Error fetching photos: ${ex.message}');
        }
      }
    } on DioException catch (ex) {
      print(' first Error fetching photos: ${ex.message}');
      print('Error fetching photos: ${ex.message}');
    }
  }
}
