import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/model/photo.dart';

import 'people_photo_event.dart';
import 'people_photo_state.dart';

class PeoplePhotoBloc extends Bloc<IPeoplePhotoEvent, IPeoplePhotoState> {
  int curentpage = 0;
  int totalpage = 0;
  List<Photo> wallpaper = [];
  List<Photo> allwallpaper = [];
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://api.pexels.com/v1/"));
  var dio = Dio();
  PeoplePhotoBloc() : super(LoadPeoplePhotoState()) {
    on<PeoplePhotoEvent>((event, emit) async {
      emit(LoadPeoplePhotoState());
      wallpaper.clear();
      try {
        var response = await _dio.get("search",
            queryParameters: {
              "query": "people",
            },
            options: Options(headers: {
              "Authorization":
                  "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
            }));
        if (response.statusCode == 200) {
          curentpage = response.data['page'];
          totalpage = response.data['per_page'];

          await Future.delayed(Duration(seconds: 3));
          emit(PeoplePhotoState(wallpaper, allwallpaper, true, true));
          try {
            response = await _dio.get("search",
                queryParameters: {
                  "query": "People",
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
              emit(PeoplePhotoState(wallpaper, allwallpaper, true, false));
            } else {
              emit(PeoplePhotoState(wallpaper, allwallpaper, false, false));
            }
          } on DioException catch (ex) {
            emit(ErrorPeoplePhotoState());
            print(' secound Error fetching photos: ${ex.message}');
            print('Error fetching photos: ${ex.message}');
            return;
          }
        }
      } on DioException catch (ex) {
        print(' first Error fetching photos: ${ex.message}');
        print('Error fetching photos: ${ex.message}');
        emit(ErrorPeoplePhotoState());
      }
    });
    on<LoadAllPeoplePhotoEvent>((event, emit) async {
      emit(PeoplePhotoState(wallpaper, allwallpaper, true, true));
      for (curentpage; curentpage <= totalpage; curentpage++) {
        try {
          var response = await _dio.get("search",
              queryParameters: {
                "query": "People",
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
            emit(PeoplePhotoState(wallpaper, allwallpaper, true, false));
          } else {
            emit(PeoplePhotoState(wallpaper, allwallpaper, false, false));
          }
        } on DioException catch (ex) {
          emit(ErrorPeoplePhotoState());
          print(' secound Error fetching photos: ${ex.message}');
          print('Error fetching photos: ${ex.message}');
          return;
        }
        await Future.delayed(Duration(seconds: 3));
      }
    });
  }
}