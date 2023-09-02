import 'package:bloc/bloc.dart';
import 'package:wallpaper/bloc/nature/nature_photo_event.dart';
import 'package:wallpaper/bloc/nature/nature_photo_state.dart';
import 'package:wallpaper/model/photo.dart';
import 'package:wallpaper/repository/nathurephotorepository.dart';

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
      // emit(NaturePhotoState(wallpaper, allwallpaper, true, true));
      // for (curentpage; curentpage <= totalpage; curentpage++) {
      //   try {
      //     var response = await _dio.get("search",
      //         queryParameters: {
      //           "query": "Nature",
      //           "page": curentpage,
      //           "per_page": totalpage
      //         },
      //         options: Options(headers: {
      //           "Authorization":
      //               "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
      //         }));
      //     if (response.statusCode == 200) {
      //       allwallpaper.addAll(response.data['photos']
      //           .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
      //           .toList());
      //       emit(NaturePhotoState(wallpaper, allwallpaper, true, false));
      //     } else {
      //       emit(NaturePhotoState(wallpaper, allwallpaper, false, false));
      //     }
      //   } on DioException catch (ex) {
      //     emit(ErrorNaturePhotoState());
      //     print(' secound Error fetching photos: ${ex.message}');
      //     print('Error fetching photos: ${ex.message}');
      //     return;
      //   }
      //   await Future.delayed(Duration(seconds: 3));
      // }
      // emit(NaturePhotoState(wallpaper, allwallpaper, false, false));
    });
  }
}
