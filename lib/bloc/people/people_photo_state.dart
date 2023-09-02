import 'package:wallpaper/model/photo.dart';

abstract class IPeoplePhotoState {}

class LoadPeoplePhotoState extends IPeoplePhotoState {}

class ErrorPeoplePhotoState extends IPeoplePhotoState {
  int curentpage;
  ErrorPeoplePhotoState(this.curentpage);
}

class PeoplePhotoState extends IPeoplePhotoState {
  List<Photo> allwallpaper;
  int totalpage;
  int curentpage;
  PeoplePhotoState(this.allwallpaper, this.totalpage, this.curentpage);
}
