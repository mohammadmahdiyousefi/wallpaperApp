import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/model/photo.dart';

import 'animal_photo_event.dart';
import 'animal_photo_state.dart';

class AnimalPhotoBloc extends Bloc<IAnimalPhotoEvent, IAnimalPhotoState> {
  int curentpage = 0;
  int totalpage = 0;
  List<Photo> wallpaper = [];
  List<Photo> allwallpaper = [];
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://api.pexels.com/v1/"));
  var dio = Dio();
  AnimalPhotoBloc() : super(LoadAnimalPhotoState()) {
    on<AnimalPhotoEvent>((event, emit) async {
      emit(LoadAnimalPhotoState());
      wallpaper.clear();
      try {
        var response = await _dio.get("search",
            queryParameters: {
              "query": "animal",
            },
            options: Options(headers: {
              "Authorization":
                  "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
            }));
        if (response.statusCode == 200) {
          curentpage = response.data['page'];
          totalpage = response.data['per_page'];

          await Future.delayed(Duration(seconds: 3));
          emit(AnimalPhotoState(wallpaper, allwallpaper, true, true));
          try {
            response = await _dio.get("search",
                queryParameters: {
                  "query": "animal",
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
              emit(AnimalPhotoState(wallpaper, allwallpaper, true, false));
            } else {
              emit(AnimalPhotoState(wallpaper, allwallpaper, false, false));
            }
          } on DioException catch (ex) {
            emit(ErrorAnimalPhotoState());
            print(' secound Error fetching photos: ${ex.message}');
            print('Error fetching photos: ${ex.message}');
            return;
          }
        }
      } on DioException catch (ex) {
        print(' first Error fetching photos: ${ex.message}');
        print('Error fetching photos: ${ex.message}');
        emit(ErrorAnimalPhotoState());
      }
    });
    on<LoadAllAnimalPhotoEvent>((event, emit) async {
      emit(AnimalPhotoState(wallpaper, allwallpaper, true, true));
      for (curentpage; curentpage <= totalpage; curentpage++) {
        try {
          var response = await _dio.get("search",
              queryParameters: {
                "query": "animal",
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
            emit(AnimalPhotoState(wallpaper, allwallpaper, true, false));
          } else {
            emit(AnimalPhotoState(wallpaper, allwallpaper, false, false));
          }
        } on DioException catch (ex) {
          emit(ErrorAnimalPhotoState());
          print(' secound Error fetching photos: ${ex.message}');
          print('Error fetching photos: ${ex.message}');
          return;
        }
        await Future.delayed(Duration(seconds: 3));
      }
    });
  }
}
