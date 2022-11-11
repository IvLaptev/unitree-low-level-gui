import 'dart:math';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

class Settings {
  String ip = '';
  String port = '';
  String secret = '';

  Settings() {
    secret = String.fromCharCodes(Iterable.generate(
        32, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}
