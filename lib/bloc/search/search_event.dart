abstract class ISearchEvent {}

class SearchEvent extends ISearchEvent {
  String text;
  SearchEvent(this.text);
}

class LoadAllSearchEventEvent extends ISearchEvent {
  int number;
  LoadAllSearchEventEvent(this.number);
}
