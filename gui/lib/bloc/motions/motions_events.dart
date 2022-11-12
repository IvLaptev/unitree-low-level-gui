part of 'motions_bloc.dart';

abstract class MotionsEvent {}

class MotionAdded extends MotionsEvent {
  MotionAdded(this.motion);

  final Motion motion;
}

class MotionChanged extends MotionsEvent {
  MotionChanged(this.motion, this.index);

  final Motion motion;
  final int index;
}

class MotionRemoved extends MotionsEvent {
  MotionRemoved(this.index);

  final int index;
}

class MotionsCleared extends MotionsEvent {}

class MotionsSent extends MotionsEvent {}
