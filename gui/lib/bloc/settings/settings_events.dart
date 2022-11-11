part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class ApiUrlChanged extends SettingsEvent {
  ApiUrlChanged(this.url);

  final String url;
}

class MinervaUrlChanged extends SettingsEvent {
  MinervaUrlChanged(this.url);

  final String url;
}
