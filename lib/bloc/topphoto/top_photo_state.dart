import 'package:photofetchpro/model/photo.dart';

abstract class ITopPhotoState {}

class LoadTopPhotoState extends ITopPhotoState {}

class ErrorTopPhotoState extends ITopPhotoState {
  int curentpage;
  ErrorTopPhotoState(this.curentpage);
}

class TopPhotoState extends ITopPhotoState {
  List<Photo> allwallpaper;
  int totalpage;
  int curentpage;
  TopPhotoState(this.allwallpaper, this.totalpage, this.curentpage);
}
