import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui/models/motion.dart';
import 'package:gui/resources/api_provider.dart';

part 'motions_state.dart';
part 'motions_events.dart';

class MotionsBloc extends Bloc<MotionsEvent, MotionsState> {
  MotionsBloc() : super(MotionsState([])) {
    on<MotionAdded>(_onMotionAdded);
    on<MotionRemoved>(_onMotionRemoved);
    on<MotionsCleared>(_onMotionsCleared);
    on<MotionsSent>(_onMotionsSent);
    on<MotionChanged>(_onMotionChanged);
  }

  void _onMotionAdded(MotionAdded event, Emitter emit) {
    var motions = state.motions;
    motions.add(event.motion);
    emit(MotionsState(motions));
  }

  void _onMotionRemoved(MotionRemoved event, Emitter emit) {
    var motions = state.motions;
    motions.removeAt(event.index);
    emit(MotionsState(motions));
  }

  void _onMotionsCleared(MotionsCleared event, Emitter emit) =>
      emit(MotionsState([]));

  void _onMotionsSent(MotionsSent event, Emitter emit) {
    ApiProvider.sendMotions(state.motions)
        .then((_) => emit(
            MotionsState(state.motions, snackbarText: 'Successfully sent')))
        .catchError((e) => emit(MotionsState(state.motions, snackbarText: e)));
  }

  void _onMotionChanged(MotionChanged event, Emitter emit) {
    var motions = state.motions;
    motions[event.index] = event.motion;
    emit(MotionsState(motions));
  }
}
