import 'package:dartz/dartz.dart';

abstract class IHomeState {}

class LoadHomeState extends IHomeState {}

class ErrorHomeState extends IHomeState {}

class HomeState extends IHomeState {
  Either<String, Map> getallphoto;
  Either<String, Map> gettopphoto;
  Either<String, Map> getnaturephoto;
  Either<String, Map> getanimalphoto;
  Either<String, Map> getpeoplephoto;
  HomeState(this.getallphoto, this.gettopphoto, this.getnaturephoto,
      this.getanimalphoto, this.getpeoplephoto);
}
