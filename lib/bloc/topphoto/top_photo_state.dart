import 'package:wallpaper/model/photo.dart';

abstract class ITopPhotoState {}

class LoadTopPhotoState extends ITopPhotoState {}

class ErrorTopPhotoState extends ITopPhotoState {}

class TopPhotoState extends ITopPhotoState {
  List<Photo> wallpaper;
  List<Photo> allwallpaper;
  bool isloaded;
  bool lodingsate;
  TopPhotoState(
      this.wallpaper, this.allwallpaper, this.isloaded, this.lodingsate);
}
