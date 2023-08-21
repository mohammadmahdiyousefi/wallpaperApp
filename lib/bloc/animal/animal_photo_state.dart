import 'package:wallpaper/model/photo.dart';

abstract class IAnimalPhotoState {}

class LoadAnimalPhotoState extends IAnimalPhotoState {}

class ErrorAnimalPhotoState extends IAnimalPhotoState {}

class AnimalPhotoState extends IAnimalPhotoState {
  List<Photo> wallpaper;
  List<Photo> allwallpaper;
  bool isloaded;
  bool lodingsate;
  AnimalPhotoState(
      this.wallpaper, this.allwallpaper, this.isloaded, this.lodingsate);
}
