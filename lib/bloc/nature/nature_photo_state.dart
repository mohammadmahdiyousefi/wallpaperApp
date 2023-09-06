import 'package:photofetchpro/model/photo.dart';

abstract class INaturePhotoState {}

class LoadNaturePhotoState extends INaturePhotoState {}

class ErrorNaturePhotoState extends INaturePhotoState {
  int curentpage;
  ErrorNaturePhotoState(this.curentpage);
}

class NaturePhotoState extends INaturePhotoState {
  List<Photo> allwallpaper;
  int totalpage;
  int curentpage;
  NaturePhotoState(this.allwallpaper, this.totalpage, this.curentpage);
}
