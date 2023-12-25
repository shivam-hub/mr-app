abstract class HomeScreenState {
   List<dynamic> get schedules => [];
}

class HomeScreenInitialState extends HomeScreenState {}

class HomeScreenLoadingState extends HomeScreenState {}

class DataFetchedState extends HomeScreenState {
  @override
  final List<dynamic> schedules;

  DataFetchedState(this.schedules);
}

class HomeScreenErrorState extends HomeScreenState {}
