import 'package:bloc/bloc.dart';
import 'package:photofetchpro/bloc/nature/nature_photo_event.dart';
import 'package:photofetchpro/bloc/nature/nature_photo_state.dart';
import 'package:photofetchpro/model/photo.dart';
import 'package:photofetchpro/repository/nathurephotorepository.dart';

import '../../di/di.dart';

class NaturePhotoBloc extends Bloc<INaturePhotoEvent, INaturePhotoState> {
  int curentpage = 0;
  int totalpage = 0;
  List<Photo> allwallpaper = [];
  final INathurePhotoRepository _repository = locator.get();
  NaturePhotoBloc() : super(LoadNaturePhotoState()) {
    on<LoadAllNaturePhotoEvent>((event, emit) async {
      emit(LoadNaturePhotoState());
      allwallpaper.clear();
      var response = await _repository.getallphotorepository(event.number);

      response.fold((l) {
        emit(ErrorNaturePhotoState(event.number));
        return 0;
      }, (r) {
        totalpage = r["per_page"];
        curentpage = r["page"];
        allwallpaper.addAll(r['photos']
            .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
            .toList());
        emit(NaturePhotoState(allwallpaper, totalpage, curentpage));
        return 0;
      });
    });
  }
}
