import 'package:bloc/bloc.dart';
import 'package:nurene_app/blocs/plan_visit/plan_visit_event.dart';
import 'package:nurene_app/blocs/plan_visit/plan_visit_state.dart';

class PlanVisitBloc extends Bloc<PlanVisitEvent, PlanVisitState> {
  PlanVisitBloc() : super(PlanVisitInitialState());

  @override
  Stream<PlanVisitState> mapEventToState(PlanVisitEvent event) async* {
    if (event is DoctorSelectedEvent) {
      // Handle the logic for doctor selection here
      yield PlanVisitLoadingState(); // You can emit a loading state if needed

      // Perform any asynchronous tasks here (e.g., fetching address based on the doctor)
      try {
        // Simulate loading data
        await Future.delayed(const Duration(seconds: 2));
        // Update the state with the selected doctor
        yield PlanVisitSuccessState();
      } catch (e) {
        yield PlanVisitErrorState('Error selecting doctor');
      }
    } else if (event is SavePlanVisitDataEvent) {
      // Handle the logic for saving data here
      yield PlanVisitLoadingState(); // You can emit a loading state if needed

      // Perform any asynchronous tasks here (e.g., saving data to the backend)
      try {
        // Simulate saving data
        await Future.delayed(const Duration(seconds: 2));
        // Update the state after successful data save
        yield PlanVisitSuccessState();
      } catch (e) {
        yield PlanVisitErrorState('Error saving data');
      }
    }
  }
}
