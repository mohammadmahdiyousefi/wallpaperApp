import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/bloc/search/search_event.dart';
import 'package:wallpaper/bloc/search/search_state.dart';
import 'package:wallpaper/repository/searchrepository.dart';

import '../../di/di.dart';
import '../../model/photo.dart';

class SearchBloc extends Bloc<ISearchEvent, ISearchState> {
  var dio = Dio();
  int curentpage = 0;
  int totalpage = 0;
  List<Photo> wallpaper = [];
  List<Photo> allwallpaper = [];
  final ISearchPhotoRepository _repository = locator.get();
  SearchBloc() : super(InitSearchState()) {
    on<SearchEvent>((event, emit) async {
      emit(LoadSearchState());
      allwallpaper.clear();
      var response = await _repository.getphotorepository(event.text);
      response.fold((l) {
        emit(ErrorSearchState(1));
        return 0;
      }, (r) {
        totalpage = r["per_page"];
        curentpage = r["page"];
        allwallpaper.addAll(r['photos']
            .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
            .toList());
        emit(SearchState(wallpaper, allwallpaper, totalpage, curentpage));
        return 0;
      });
    });
    on<LoadAllSearchEventEvent>((event, emit) async {
      emit(LoadSearchState());
      allwallpaper.clear();
      var response = await _repository.getallphotorepository(event.number);
      response.fold((l) {
        emit(ErrorSearchState(curentpage));
        return 0;
      }, (r) {
        totalpage = r["per_page"];
        curentpage = r["page"];
        allwallpaper.addAll(r['photos']
            .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
            .toList());
        emit(SearchState(wallpaper, allwallpaper, totalpage, curentpage));
        return 0;
      });
    });
  }
}
