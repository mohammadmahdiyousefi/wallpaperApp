import 'package:wallpaper/model/photo.dart';

abstract class ISavePhotoEvent {}

class SavePhotoEvent extends ISavePhotoEvent {
  Photo photo;
  SavePhotoEvent(this.photo);
}

class LoadSavePhotoEvent extends ISavePhotoEvent {
  LoadSavePhotoEvent();
}
