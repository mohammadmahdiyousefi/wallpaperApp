import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_event.dart';
import 'package:wallpaper/bloc/homepagebloc/homepage_state.dart';
import '../../di/di.dart';
import '../../repository/allphotorepository.dart';
import '../../repository/animalphotorepository.dart';
import '../../repository/nathurephotorepository.dart';
import '../../repository/peoplephotorepository.dart';
import '../../repository/topphotorepository.dart';

class Homebloc extends Bloc<IHomeEvent, IHomeState> {
  final IAllPhotoRepository _repository = locator.get();
  final ITopPhotoRepository _toprepository = locator.get();
  final INathurePhotoRepository _naturerepository = locator.get();
  final IAnimalPhotoRepository _animalrepository = locator.get();
  final IPeoplePhotoRepository _peoplerepository = locator.get();
  Homebloc() : super(LoadHomeState()) {
    Either<String, Map> allresponse = right({});
    Either<String, Map> topresponse = right({});
    Either<String, Map> natureresponse = right({});
    Either<String, Map> animalresponse = right({});
    Either<String, Map> peopleresponse = right({});

    on<HomeEvent>((event, emit) async {
      emit(LoadHomeState());
      try {
        allresponse = await _repository.getphotorepository();
        Future.delayed(const Duration(seconds: 1));
        topresponse = await _toprepository.getphotorepository();
        Future.delayed(const Duration(seconds: 1));
        natureresponse = await _naturerepository.getphotorepository();
        Future.delayed(const Duration(seconds: 1));
        animalresponse = await _animalrepository.getphotorepository();
        Future.delayed(const Duration(seconds: 1));
        peopleresponse = await _peoplerepository.getphotorepository();
        emit(HomeState(allresponse, topresponse, natureresponse, animalresponse,
            peopleresponse));
      } catch (ex) {
        emit(ErrorHomeState());
      }
    });
    on<HomeAllPhotoEvent>((event, emit) async {
      allresponse = await _repository.getphotorepository();
      emit(HomeState(allresponse, topresponse, natureresponse, animalresponse,
          peopleresponse));
    });
    on<HomeTopPhotoEvent>((event, emit) async {
      topresponse = await _toprepository.getphotorepository();
      emit(HomeState(allresponse, topresponse, natureresponse, animalresponse,
          peopleresponse));
    });
    on<HomeNaturePhotoEvent>((event, emit) async {
      natureresponse = await _naturerepository.getphotorepository();
      emit(HomeState(allresponse, topresponse, natureresponse, animalresponse,
          peopleresponse));
    });
    on<HomeAnimalPhotoEvent>((event, emit) async {
      animalresponse = await _animalrepository.getphotorepository();
      emit(HomeState(allresponse, topresponse, natureresponse, animalresponse,
          peopleresponse));
    });
    on<HomePeoplePhotoEvent>((event, emit) async {
      peopleresponse = await _peoplerepository.getphotorepository();
      emit(HomeState(allresponse, topresponse, natureresponse, animalresponse,
          peopleresponse));
    });
  }
}
