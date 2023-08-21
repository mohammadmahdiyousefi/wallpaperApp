import 'package:wallpaper/model/photo.dart';

abstract class IPeoplePhotoState {}

class LoadPeoplePhotoState extends IPeoplePhotoState {}

class ErrorPeoplePhotoState extends IPeoplePhotoState {}

class PeoplePhotoState extends IPeoplePhotoState {
  List<Photo> wallpaper;
  List<Photo> allwallpaper;
  bool isloaded;
  bool lodingsate;
  PeoplePhotoState(
      this.wallpaper, this.allwallpaper, this.isloaded, this.lodingsate);
}
