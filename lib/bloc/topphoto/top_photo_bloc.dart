import 'package:bloc/bloc.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_event.dart';
import 'package:wallpaper/bloc/topphoto/top_photo_state.dart';
import 'package:wallpaper/model/photo.dart';
import 'package:wallpaper/repository/topphotorepository.dart';

import '../../di/di.dart';

class TopPhotoBloc extends Bloc<ITopPhotoEvent, ITopPhotoState> {
  int curentpage = 0;
  int totalpage = 0;

  List<Photo> allwallpaper = [];
  final ITopPhotoRepository _repository = locator.get();

  TopPhotoBloc() : super(LoadTopPhotoState()) {
    on<LoadTopPhotoEvent>((event, emit) async {
      emit(LoadTopPhotoState());
      allwallpaper.clear();
      var response = await _repository.getallphotorepository(event.number);
      response.fold((l) {
        emit(ErrorTopPhotoState(event.number));
        return 0;
      }, (r) {
        totalpage = r["per_page"];
        curentpage = r["page"];
        allwallpaper.addAll(r['photos']
            .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
            .toList());
        emit(TopPhotoState(allwallpaper, totalpage, curentpage));
        return 0;
      });
    });
  }
}
