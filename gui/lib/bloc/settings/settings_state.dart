part of 'settings_bloc.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

_generateSecret() => String.fromCharCodes(Iterable.generate(
    32, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class SettingsState {
  SettingsState({this.apiUrl = '', this.minervaUrl = '', this.secret = ''}) {
    if (secret.isEmpty) {
      secret = _generateSecret();
    }
  }

  String apiUrl;
  String minervaUrl;
  String secret;
}
