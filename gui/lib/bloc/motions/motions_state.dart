part of 'motions_bloc.dart';

class MotionsState {
  MotionsState(this.motions, {this.snackbarText});

  final List<Motion> motions;
  final String? snackbarText;
}
