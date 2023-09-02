abstract class IAllPhotoEvent {}

class AllPhotoEvent extends IAllPhotoEvent {}

class LoadAllPhotoEvent extends IAllPhotoEvent {
  int number;
  LoadAllPhotoEvent(this.number);
}
