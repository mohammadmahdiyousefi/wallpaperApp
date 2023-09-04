import 'package:bloc/bloc.dart';
import 'package:wallpaper/model/photo.dart';
import 'package:wallpaper/repository/peoplephotorepository.dart';

import '../../di/di.dart';
import 'people_photo_event.dart';
import 'people_photo_state.dart';

class PeoplePhotoBloc extends Bloc<IPeoplePhotoEvent, IPeoplePhotoState> {
  int curentpage = 0;
  int totalpage = 0;
  List<Photo> allwallpaper = [];
  final IPeoplePhotoRepository _repository = locator.get();
  PeoplePhotoBloc() : super(LoadPeoplePhotoState()) {
    on<LoadAllPeoplePhotoEvent>((event, emit) async {
      emit(LoadPeoplePhotoState());
      allwallpaper.clear();
      var response = await _repository.getallphotorepository(event.number);
      response.fold((l) {
        emit(ErrorPeoplePhotoState(event.number));
        return 0;
      }, (r) {
        totalpage = r["per_page"];
        curentpage = r["page"];
        allwallpaper.addAll(r['photos']
            .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
            .toList());
        emit(PeoplePhotoState(allwallpaper, totalpage, curentpage));
        return 0;
      });
    });
  }
}
