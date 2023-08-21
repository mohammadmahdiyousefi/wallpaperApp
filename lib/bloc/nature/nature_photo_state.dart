import 'package:wallpaper/model/photo.dart';

abstract class INaturePhotoState {}

class LoadNaturePhotoState extends INaturePhotoState {}

class ErrorNaturePhotoState extends INaturePhotoState {}

class NaturePhotoState extends INaturePhotoState {
  List<Photo> wallpaper;
  List<Photo> allwallpaper;
  bool isloaded;
  bool lodingsate;
  NaturePhotoState(
      this.wallpaper, this.allwallpaper, this.isloaded, this.lodingsate);
}
