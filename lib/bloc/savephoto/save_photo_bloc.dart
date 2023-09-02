import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wallpaper/bloc/savephoto/save_photo_event.dart';
import 'package:wallpaper/bloc/savephoto/save_photo_state.dart';
import 'package:wallpaper/model/photo.dart';

class SavePhotoBloc extends Bloc<ISavePhotoEvent, ISavePhotoState> {
  var box = Hive.box("photo");
  List<Photo> photos = [];
  SavePhotoBloc() : super(SavePhotoState([])) {
    on<SavePhotoEvent>((event, emit) async {
      emit(LoadingSavePhotoState());
      String encode = jsonEncode(event.photo);
      if (box.keys.contains(event.photo.id)) {
        await box.delete(event.photo.id);
      } else {
        await box.put(event.photo.id, encode);
      }
      await loadphoto();
      if (photos.isEmpty) {
        emit(EmpetySavePhotoState());
      } else {
        emit(SavePhotoState(photos));
      }
    });
    on<LoadSavePhotoEvent>((event, emit) async {
      loadphoto();
      if (photos.isEmpty) {
        emit(EmpetySavePhotoState());
      } else {
        emit(SavePhotoState(photos));
      }
    });
  }
  Future<void> loadphoto() async {
    photos.clear();
    for (var decode in box.values) {
      var i = jsonDecode(decode);
      photos.add(Photo.fromJson(i));
    }
  }
}
