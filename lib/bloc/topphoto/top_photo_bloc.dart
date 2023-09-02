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
      //   emit(TopPhotoState(wallpaper, allwallpaper, true, true));
      //   for (curentpage; curentpage <= totalpage; curentpage++) {
      //     try {
      //       var response = await _dio.get("popular",
      //           queryParameters: {"page": curentpage, "per_page": totalpage},
      //           options: Options(headers: {
      //             "Authorization":
      //                 "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
      //           }));
      //       if (response.statusCode == 200) {
      //         allwallpaper.addAll(response.data['photos']
      //             .map<Photo>((jsonObject) => Photo.fromJson(jsonObject))
      //             .toList());
      //         emit(TopPhotoState(wallpaper, allwallpaper, true, false));
      //       } else {
      //         emit(TopPhotoState(wallpaper, allwallpaper, false, false));
      //       }
      //     } on DioException catch (ex) {
      //       emit(ErrorTopPhotoState());
      //       print(' secound Error fetching photos: ${ex.message}');
      //       print('Error fetching photos: ${ex.message}');
      //       return;
      //     }
      //     await Future.delayed(Duration(seconds: 3));
      //   }
      //   emit(TopPhotoState(wallpaper, allwallpaper, false, false));
    });
  }
}
