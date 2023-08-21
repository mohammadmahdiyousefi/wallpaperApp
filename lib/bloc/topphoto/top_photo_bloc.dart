import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_event.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_state.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/bloc/topphoto/top_photo_event.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_state.dart';
import 'package:wallpaper/model/photo.dart';

class TopPhotoBloc extends Bloc<ITopPhotoEvent, ITopPhotoState> {
  int curentpage = 0;
  int totalpage = 0;
  List<Photo> wallpaper = [];
  List<Photo> allwallpaper = [];
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://api.pexels.com/v1/"));
  var dio = Dio();
  TopPhotoBloc() : super(LoadTopPhotoState()) {
    on<TopPhotoEvent>((event, emit) async {
      emit(LoadTopPhotoState());
      wallpaper.clear();
      try {
        var response = await _dio.get("popular",
            options: Options(headers: {
              "Authorization":
                  "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
            }));
        if (response.statusCode == 200) {
          curentpage = response.data['page'];
          totalpage = response.data['per_page'];
          await Future.delayed(Duration(seconds: 3));
          emit(TopPhotoState(wallpaper, allwallpaper, true, true));
          try {
            response = await _dio.get("popular",
                queryParameters: {"page": 1, "per_page": totalpage},
                options: Options(headers: {
                  "Authorization":
                      "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
                }));
            if (response.statusCode == 200) {
              wallpaper.addAll(response.data['photos']
                  .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                  .toList());
              emit(TopPhotoState(wallpaper, allwallpaper, true, false));
            } else {
              emit(TopPhotoState(wallpaper, allwallpaper, false, false));
            }
          } on DioException catch (ex) {
            emit(ErrorTopPhotoState());
            print(' secound Error fetching photos: ${ex.message}');
            print('Error fetching photos: ${ex.message}');
            return;
          }
        }
      } on DioException catch (ex) {
        print(' first Error fetching photos: ${ex.message}');
        print('Error fetching photos: ${ex.message}');
        emit(ErrorTopPhotoState());
      }
    });
    on<LoadTopPhotoEvent>((event, emit) async {
      emit(TopPhotoState(wallpaper, allwallpaper, true, true));
      for (curentpage; curentpage <= totalpage; curentpage++) {
        try {
          var response = await _dio.get("popular",
              queryParameters: {"page": curentpage, "per_page": totalpage},
              options: Options(headers: {
                "Authorization":
                    "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
              }));
          if (response.statusCode == 200) {
            allwallpaper.addAll(response.data['photos']
                .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                .toList());
            emit(TopPhotoState(wallpaper, allwallpaper, true, false));
          } else {
            emit(TopPhotoState(wallpaper, allwallpaper, false, false));
          }
        } on DioException catch (ex) {
          emit(ErrorTopPhotoState());
          print(' secound Error fetching photos: ${ex.message}');
          print('Error fetching photos: ${ex.message}');
          return;
        }
        await Future.delayed(Duration(seconds: 3));
      }
    });
  }
}
