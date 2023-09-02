import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/model/photo.dart';
import 'package:wallpaper/repository/animalphotorepository.dart';

import '../../di/di.dart';
import 'animal_photo_event.dart';
import 'animal_photo_state.dart';

class AnimalPhotoBloc extends Bloc<IAnimalPhotoEvent, IAnimalPhotoState> {
  int curentpage = 0;
  int totalpage = 0;
  List<Photo> allwallpaper = [];
  final IAnimalPhotoRepository _repository = locator.get();
  AnimalPhotoBloc() : super(LoadAnimalPhotoState()) {
    on<LoadAllAnimalPhotoEvent>((event, emit) async {
      emit(LoadAnimalPhotoState());
      allwallpaper.clear();
      var response = await _repository.getallphotorepository(event.number);

      response.fold((l) {
        emit(ErrorAnimalPhotoState(event.number));
        return 0;
      }, (r) {
        totalpage = r["per_page"];
        curentpage = r["page"];
        allwallpaper.addAll(r['photos']
            .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
            .toList());
        emit(AnimalPhotoState(allwallpaper, totalpage, curentpage));
        return 0;
      });
    });
  }
}
