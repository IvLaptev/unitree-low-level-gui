import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

class Settings {
  String ip = '';
  String port = '';
  String secret = '';

  Settings() {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();

    secret = String.fromCharCodes(Iterable.generate(
        32, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }
}

class SettingsBloc {
  Settings _settings = Settings();

  SettingsBloc() {
    _settings = Settings();
    _actionController.stream.listen(changeStream);
    _setValue.add(_settings);
  }

  final _settingsSteram = BehaviorSubject<Settings>.seeded(Settings());

  Stream get settings => _settingsSteram.stream;
  Sink get _setValue => _settingsSteram.sink;

  StreamController _actionController = StreamController<Settings>();
  StreamSink get changeSettings => _actionController.sink;

  void changeStream(data) async {
    print(data.ip);
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

    _setValue.add(_settings);
  }

  void dispose() {
    _actionController.close();
    _settingsSteram.close();
  }
}
