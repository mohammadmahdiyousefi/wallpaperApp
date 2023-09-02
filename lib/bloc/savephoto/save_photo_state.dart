import 'package:wallpaper/model/photo.dart';

abstract class ISavePhotoState {}

class LoadingSavePhotoState extends ISavePhotoState {}

class SavePhotoState extends ISavePhotoState {
  List<Photo> photos;
  SavePhotoState(this.photos);
}

class EmpetySavePhotoState extends ISavePhotoState {}
