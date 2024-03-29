import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui/models/action.dart';
import 'package:gui/resources/actions_provider.dart';

part 'minerva_event.dart';
part 'minerva_state.dart';

class MinervaBloc extends Bloc<MinervaEvent, MinervaState> {
  ActionsProvider? actionsProvider;

  MinervaBloc() : super(const MinervaState()) {
    on<UrlChanged>(_onUrlChanged);
    on<ActionsRequested>(_onActionsRequested);
    on<ActionsReceived>(_onActionsReceived);
    on<ActionStarted>(_onActionStarted);
    on<ActionStopped>(_onActionStopped);
    on<ActionLogsReceived>(_onActionLogsReceived);

    actionsProvider = ActionsProvider(add);
  }

  void _onUrlChanged(UrlChanged event, Emitter<MinervaState> emit) async {
    actionsProvider!.setUrl(event.url);
  }

  void _onActionsRequested(
      ActionsRequested event, Emitter<MinervaState> emit) async {
    actionsProvider!.getActions();
  }

  void _onActionsReceived(
      ActionsReceived event, Emitter<MinervaState> emit) async {
    emit(MinervaState(actions: event.actions));
  }

  void _onActionStarted(ActionStarted event, Emitter<MinervaState> emit) async {
    actionsProvider!.startAction(event.actionId);
    state.actions.firstWhere((action) => event.actionId == action.id).started =
        true;
    emit(MinervaState(actions: state.actions));
  }

  void _onActionStopped(ActionStopped event, Emitter<MinervaState> emit) async {
    actionsProvider!.stopAction(event.actionId);
    state.actions.firstWhere((action) => event.actionId == action.id).started =
        false;
    emit(MinervaState(actions: state.actions));
  }

  void _onActionLogsReceived(
      ActionLogsReceived event, Emitter<MinervaState> emit) async {
    List<String> logs = state.actions
        .firstWhere((action) => event.actionId == action.id)
        .logs
        .toList();
    logs.add(event.logLine);
    state.actions.firstWhere((action) => event.actionId == action.id).logs =
        logs;
    print(state.actions);
    emit(MinervaState(actions: state.actions));
  }
}
