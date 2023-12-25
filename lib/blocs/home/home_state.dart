abstract class HomeScreenState {}

class HomeScreenInitialState extends HomeScreenState {}

class HomeScreenLoadingState extends HomeScreenState {}

class DataFetchedState extends HomeScreenState {
  final List<dynamic> schedules;

  DataFetchedState(this.schedules);
}

class HomeScreenErrorState extends HomeScreenState {}
