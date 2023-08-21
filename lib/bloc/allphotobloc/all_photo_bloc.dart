import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_event.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_state.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/model/photo.dart';

class AllPhotoBloc extends Bloc<IAllPhotoEvent, IAllPhotoState> {
  int curentpage = 0;
  int totalpage = 0;
  List<Photo> wallpaper = [];
  List<Photo> allwallpaper = [];
  var dio = Dio();
  AllPhotoBloc() : super(LoadAllPhotoState()) {
    on<AllPhotoEvent>((event, emit) async {
      emit(LoadAllPhotoState());
      wallpaper.clear();
      try {
        var response = await dio.get("https://api.pexels.com/v1/curated",
            options: Options(headers: {
              "Authorization":
                  "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
            }));
        if (response.statusCode == 200) {
          curentpage = response.data['page'];
          totalpage = response.data['per_page'];
          emit(AllPhotoState(wallpaper, allwallpaper, true, true));
          await Future.delayed(Duration(seconds: 1));
          try {
            response = await dio.get("https://api.pexels.com/v1/curated",
                queryParameters: {"page": 1, "per_page": totalpage},
                options: Options(headers: {
                  "Authorization":
                      "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
                }));
            if (response.statusCode == 200) {
              wallpaper.addAll(response.data['photos']
                  .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                  .toList());
              emit(AllPhotoState(wallpaper, allwallpaper, true, false));
            } else {
              emit(AllPhotoState(wallpaper, allwallpaper, false, false));
            }
          } on DioException catch (ex) {
            emit(ErrorAllPhotoState());
            print(' secound Error fetching photos: ${ex.message}');
            print('Error fetching photos: ${ex.message}');
            return;
          }
        }
      } on DioException catch (ex) {
        print(' first Error fetching photos: ${ex.message}');
        print('Error fetching photos: ${ex.message}');
        emit(ErrorAllPhotoState());
      }
    });
    on<LoadAllPhotoEvent>((event, emit) async {
      emit(LoadAllPhotoState());
      allwallpaper.clear();
      emit(AllPhotoState(wallpaper, allwallpaper, true, true));
      for (curentpage; curentpage <= totalpage; curentpage++) {
        try {
          var response = await dio.get("https://api.pexels.com/v1/curated",
              queryParameters: {"page": curentpage, "per_page": totalpage},
              options: Options(headers: {
                "Authorization":
                    "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
              }));
          if (response.statusCode == 200) {
            allwallpaper.addAll(response.data['photos']
                .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
                .toList());
            emit(AllPhotoState(wallpaper, allwallpaper, true, false));
          } else {
            emit(AllPhotoState(wallpaper, allwallpaper, false, false));
          }
        } on DioException catch (ex) {
          emit(ErrorAllPhotoState());
          print(' secound Error fetching photos: ${ex.message}');
          print('Error fetching photos: ${ex.message}');
          return;
        }
        await Future.delayed(Duration(seconds: 3));
      }
    });
  }
}
