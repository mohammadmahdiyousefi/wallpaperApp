import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_event.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_state.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/bloc/nature/nature_photo_event.dart';
import 'package:wallpaper/bloc/nature/nature_photo_state.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_event.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_state.dart';
import 'package:wallpaper/model/photo.dart';

class NaturePhotoBloc extends Bloc<INaturePhotoEvent, INaturePhotoState> {
  int curentpage = 0;
  int totalpage = 0;
  List<Photo> wallpaper = [];
  List<Photo> allwallpaper = [];
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://api.pexels.com/v1/"));
  var dio = Dio();
  NaturePhotoBloc() : super(LoadNaturePhotoState()) {
    on<NaturePhotoEvent>((event, emit) async {
      emit(LoadNaturePhotoState());
      wallpaper.clear();
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
          curentpage = response.data['page'];
          totalpage = response.data['per_page'];

          await Future.delayed(Duration(seconds: 3));
          emit(NaturePhotoState(wallpaper, allwallpaper, true, true));
          try {
            response = await _dio.get("search",
                queryParameters: {
                  "query": "Nature",
                  "page": 1,
                  "per_page": totalpage
                },
                options: Options(headers: {
                  "Authorization":
                      "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
                }));
            if (response.statusCode == 200) {
              wallpaper.addAll(response.data['photos']
                  .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                  .toList());
              emit(NaturePhotoState(wallpaper, allwallpaper, true, false));
            } else {
              emit(NaturePhotoState(wallpaper, allwallpaper, false, false));
            }
          } on DioException catch (ex) {
            emit(ErrorNaturePhotoState());
            print(' secound Error fetching photos: ${ex.message}');
            print('Error fetching photos: ${ex.message}');
            return;
          }
        }
      } on DioException catch (ex) {
        print(' first Error fetching photos: ${ex.message}');
        print('Error fetching photos: ${ex.message}');
        emit(ErrorNaturePhotoState());
      }
    });
    on<LoadAllNaturePhotoEvent>((event, emit) async {
      emit(NaturePhotoState(wallpaper, allwallpaper, true, true));
      for (curentpage; curentpage <= totalpage; curentpage++) {
        try {
          var response = await _dio.get("search",
              queryParameters: {
                "query": "Nature",
                "page": curentpage,
                "per_page": totalpage
              },
              options: Options(headers: {
                "Authorization":
                    "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
              }));
          if (response.statusCode == 200) {
            allwallpaper.addAll(response.data['photos']
                .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                .toList());
            emit(NaturePhotoState(wallpaper, allwallpaper, true, false));
          } else {
            emit(NaturePhotoState(wallpaper, allwallpaper, false, false));
          }
        } on DioException catch (ex) {
          emit(ErrorNaturePhotoState());
          print(' secound Error fetching photos: ${ex.message}');
          print('Error fetching photos: ${ex.message}');
          return;
        }
        await Future.delayed(Duration(seconds: 3));
      }
    });
  }
}
