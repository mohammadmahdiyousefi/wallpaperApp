import 'package:dartz/dartz.dart';
import 'package:wallpaper/model/photo.dart';

abstract class IAllPhotoState {}

class LoadAllPhotoState extends IAllPhotoState {}

class ErrorAllPhotoState extends IAllPhotoState {
  int curentpage;
  ErrorAllPhotoState(this.curentpage);
}

class AllPhotoState extends IAllPhotoState {
  List<Photo> allwallpaper;
  int totalpage;
  int curentpage;
  AllPhotoState(this.allwallpaper, this.totalpage, this.curentpage);
}
