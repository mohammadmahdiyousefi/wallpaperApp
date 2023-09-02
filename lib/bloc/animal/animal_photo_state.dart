import 'package:wallpaper/model/photo.dart';

abstract class IAnimalPhotoState {}

class LoadAnimalPhotoState extends IAnimalPhotoState {}

class ErrorAnimalPhotoState extends IAnimalPhotoState {
  int curentpage;
  ErrorAnimalPhotoState(this.curentpage);
}

class AnimalPhotoState extends IAnimalPhotoState {
  List<Photo> allwallpaper;
  int totalpage;
  int curentpage;
  AnimalPhotoState(this.allwallpaper, this.totalpage, this.curentpage);
}
