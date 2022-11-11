import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_events.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState()) {
    on<HostChanged>(_onHostChanged);
    on<PortChanged>(_onPortChanged);
  }

  void _onHostChanged(HostChanged event, Emitter emit) {
    emit(SettingsState(
        host: event.host, port: state.port, secret: state.secret));
  }

  void _onPortChanged(PortChanged event, Emitter emit) {
    emit(SettingsState(
        host: state.host, port: event.port, secret: state.secret));
  }
}
