abstract class IPeoplePhotoEvent {}

class PeoplePhotoEvent extends IPeoplePhotoEvent {}

class LoadAllPeoplePhotoEvent extends IPeoplePhotoEvent {
  int number;
  LoadAllPeoplePhotoEvent(this.number);
}
