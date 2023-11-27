import 'dart:async';
import 'package:bloc/bloc.dart';

import 'master_event.dart';
import 'master_state.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  MasterBloc() : super(MasterInitialState());

  @override
  Stream<MasterState> mapEventToState(MasterEvent event) async* {
    if (event is DoctorSelectedEvent) {
      yield DoctorSelectedState(event.doctorName);
    } else if (event is SaveMasterDataEvent) {
      try {
        // Add your logic to save data here

        // If successful, yield success state
        yield MasterSuccessState();
      } catch (e) {
        // If there's an error, yield error state
        yield MasterErrorState('Error saving data: $e');
      }
    }
  }
}
