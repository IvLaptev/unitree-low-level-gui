part of 'minerva_bloc.dart';

abstract class MinervaEvent {}

class ActionsRequested extends MinervaEvent {}

class UrlChanged extends MinervaEvent {
  UrlChanged(this.url);

  final String url;
}

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

class ActionLogsReceived extends MinervaEvent {
  ActionLogsReceived(this.actionId, this.logLine);

  final String actionId;
  final String logLine;
}
