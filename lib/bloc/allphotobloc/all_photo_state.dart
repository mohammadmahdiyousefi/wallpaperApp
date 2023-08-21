import 'package:wallpaper/model/photo.dart';

abstract class IAllPhotoState {}

class LoadAllPhotoState extends IAllPhotoState {}

class ErrorAllPhotoState extends IAllPhotoState {}

class AllPhotoState extends IAllPhotoState {
  List<Photo> wallpaper;
  List<Photo> allwallpaper;
  bool isloaded;
  bool lodingsate;
  AllPhotoState(
      this.wallpaper, this.allwallpaper, this.isloaded, this.lodingsate);
}
