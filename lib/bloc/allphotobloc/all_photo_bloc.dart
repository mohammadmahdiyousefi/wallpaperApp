import 'package:bloc/bloc.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_event.dart';
import 'package:wallpaper/bloc/allphotobloc/all_photo_state.dart';
import 'package:wallpaper/di/di.dart';
import 'package:wallpaper/model/photo.dart';
import 'package:wallpaper/repository/allphotorepository.dart';

class AllPhotoBloc extends Bloc<IAllPhotoEvent, IAllPhotoState> {
  int curentpage = 0;
  int totalpage = 0;
  List<Photo> allwallpaper = [];
  final IAllPhotoRepository _repository = locator.get();
  AllPhotoBloc() : super(LoadAllPhotoState()) {
    on<LoadAllPhotoEvent>((event, emit) async {
      emit(LoadAllPhotoState());
      allwallpaper.clear();
      var response = await _repository.getallphotorepository(event.number);
      response.fold((l) {
        emit(ErrorAllPhotoState(event.number));
        return 0;
      }, (r) {
        totalpage = r["per_page"];
        curentpage = r["page"];
        allwallpaper.addAll(r['photos']
            .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
            .toList());
        emit(AllPhotoState(allwallpaper, totalpage, curentpage));
        return 0;
      });
    });
  }
}
