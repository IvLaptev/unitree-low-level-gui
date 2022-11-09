part of 'minerva_bloc.dart';

abstract class MinervaEvent {}

class ActionsRequested extends MinervaEvent {}

class ActionsReceived extends MinervaEvent {
  ActionsReceived(this.actions);

  final List<Action> actions;
}

class ActionStarted extends MinervaEvent {
  ActionStarted(this.actionId);

  final String actionId;
}

class ActionStopped extends MinervaEvent {
  ActionStopped(this.actionId);

  final String actionId;
}
