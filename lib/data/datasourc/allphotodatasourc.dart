// import 'package:dio/dio.dart';

// import '../../di/di.dart';
// import '../../model/photo.dart';

// abstract class IAllPhotoDataSourc {
//   Future<List<Photo>> wallpaper();
// }
// class AllPhotoDataSourc extends IAllPhotoDataSourc{
//    final Dio _dio = locator.get();
//   @override
//   Future<List<Photo>> wallpaper() async{
//     int curentpage = 0;
//   int totalpage = 0;
//     // TODO: implement wallpaper
//     try{
//        var respones=await  _dio.get("curated", options: Options(headers: {
//             "Authorization":
//                 "i2xCopa0wQh8155oyRo30e9HFcdnmOSDv7YDwLcnDr4Hs8XcfjCIBl8m"
//           }));
//           if(respones.statusCode==200){
//              curentpage = respones.data['page'];
//         totalpage = respones.data['per_page'];
//           }

//     }
  
//   }

// }