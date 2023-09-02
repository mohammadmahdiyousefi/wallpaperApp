abstract class INaturePhotoEvent {}

class NaturePhotoEvent extends INaturePhotoEvent {}

class LoadAllNaturePhotoEvent extends INaturePhotoEvent {
  int number;
  LoadAllNaturePhotoEvent(this.number);
}
