abstract class ITopPhotoEvent {}

class TopPhotoEvent extends ITopPhotoEvent {}

class LoadTopPhotoEvent extends ITopPhotoEvent {
  int number;
  LoadTopPhotoEvent(this.number);
}
