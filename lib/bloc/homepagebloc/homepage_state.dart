import '../../model/photo.dart';

abstract class IHomeState {}

class LoadHomeState extends IHomeState {}

class ErrorHomeState extends IHomeState {}

class HomeState extends IHomeState {
  List<Photo> allwallpaper = [];
  List<Photo> topwallpaper = [];
  List<Photo> junglewallpaper = [];
  HomeState(this.allwallpaper, this.topwallpaper, this.junglewallpaper);
}
