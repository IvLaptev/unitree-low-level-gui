import 'dart:async';

import 'package:gui/models/settings.dart';
import 'package:gui/resources/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  Settings _settings = Settings();

  SettingsBloc() {
    _settings = Settings();
    actionController.stream.listen(changeStream);
    _setValue.add(_settings);
  }

  final _settingsSteram = BehaviorSubject<Settings>.seeded(Settings());

  Stream get settings => _settingsSteram.stream;
  Sink get _setValue => _settingsSteram.sink;

  StreamController actionController = StreamController<Settings>();
  StreamSink get changeSettings => actionController.sink;

  void changeStream(data) async {
    if (data.ip == null) {
      _settings.ip = '';
    } else {
      _settings.ip = data.ip;
    }

    if (data.port == null) {
      _settings.port = '';
    } else {
      _settings.port = data.port;
    }

    ApiProvider.baseUrl = 'http://${_settings.ip}:${_settings.port}';

    _setValue.add(_settings);
  }

  void dispose() {
    actionController.close();
    _settingsSteram.close();
  }
}
