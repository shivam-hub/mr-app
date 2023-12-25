import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/blocs/home/home_event.dart';
import '/blocs/home/home_state.dart';
import '/services/api_services.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ApiService apiService;
  HomeScreenBloc(this.apiService) : super(HomeScreenInitialState());

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    if (event is HomeScreenInitialEvent || event is HomeScreenLoadingEvent) {
      yield HomeScreenLoadingState();
      try {
        final pref = await SharedPreferences.getInstance();
        final userDetailsStr = pref.getString('userDetails') ?? '';
        final Map<String, dynamic> userDetails = json.decode(userDetailsStr);
        final userId = userDetails['userId'];

        final res = await apiService.getSchedules(userId);
        yield DataFetchedState(res['scheduledVisit']);
      } catch (e) {
        yield HomeScreenErrorState();
      }
    }
  }
}
