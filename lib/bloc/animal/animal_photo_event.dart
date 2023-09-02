abstract class IAnimalPhotoEvent {}

class AnimalPhotoEvent extends IAnimalPhotoEvent {}

class LoadAllAnimalPhotoEvent extends IAnimalPhotoEvent {
  int number;
  LoadAllAnimalPhotoEvent(this.number);
}
