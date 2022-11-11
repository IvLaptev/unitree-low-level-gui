part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class HostChanged extends SettingsEvent {
  HostChanged(this.host);

  final String host;
}

class PortChanged extends SettingsEvent {
  PortChanged(this.port);

  final String port;
}
