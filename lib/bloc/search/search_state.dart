import '../../model/photo.dart';

abstract class ISearchState {}

class SearchState extends ISearchState {
  List<Photo> wallpaper;
  List<Photo> allwallpaper;
  int totalpage;
  int curentpage;
  SearchState(
      this.wallpaper, this.allwallpaper, this.totalpage, this.curentpage);
}

class LoadSearchState extends ISearchState {}

class ErrorSearchState extends ISearchState {
  int curentpage;
  ErrorSearchState(this.curentpage);
}

class InitSearchState extends ISearchState {}
