import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui/resources/api_provider.dart';

part 'settings_events.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState()) {
    on<ApiUrlChanged>(_onApiUrlChangedChanged);
    on<MinervaUrlChanged>(_onMinervaUrlChanged);
  }

  String _onApiUrlChangedChanged(ApiUrlChanged event, Emitter emit) {
    emit(SettingsState(
        apiUrl: event.url, minervaUrl: state.minervaUrl, secret: state.secret));
    var result = 'http://${event.url}';
    ApiProvider.setBaseUrl(result);
    return result;
  }

  String _onMinervaUrlChanged(MinervaUrlChanged event, Emitter emit) {
    emit(SettingsState(
        apiUrl: state.apiUrl, minervaUrl: event.url, secret: state.secret));
    return 'ws://${event.url}/control';
  }
}
