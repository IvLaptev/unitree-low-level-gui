import 'dart:convert';

import 'package:gui/bloc/minerva/minerva_bloc.dart';
import 'package:gui/models/action.dart';
import 'package:gui/models/ws_message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ActionsProvider {
  WebSocketChannel? channel;
  final Function _addEvent;
  String _apiUrl = '';

  ActionsProvider(this._addEvent) {
    setUrl('localhost:8080');
  }

  void getActions() {
    if (channel != null) {
      channel!.sink.add(json.encode(
          WsMessage(cmd: ActionCommands.getActions, body: []).toJson()));
    }
  }

  void startAction(String actionId) {
    if (channel != null) {
      channel!.sink.add(json.encode(
          WsMessage(cmd: ActionCommands.startAction, body: [actionId])
              .toJson()));
    }
  }

  void stopAction(String actionId) {
    if (channel != null) {
      channel!.sink.add(json.encode(
          WsMessage(cmd: ActionCommands.stopAction, body: [actionId])
              .toJson()));
    }
  }

  void _setActions(dynamic body) {
    List<Action> actions = [];
    for (var item in body) {
      actions.add(Action.fromJson(item));
    }

    _addEvent(ActionsReceived(actions));
  }

  void setUrl(String url) {
    _apiUrl = 'ws://$url/control';
    print(_apiUrl);

    try {
      if (channel != null) {
        channel!.sink.close();
      }
      channel = WebSocketChannel.connect(Uri.parse(_apiUrl));

      channel!.stream.listen((msg) {
        WsMessage message = WsMessage.fromJson(json.decode(msg));

        if (message.cmd == ActionCommands.setActions) {
          _setActions(message.body);
        } else if (message.cmd == ActionCommands.stopAction) {
          _addEvent(ActionStopped(message.body[0]));
        } else if (message.cmd == ActionCommands.addActionLogs) {
          _addEvent(ActionLogsReceived(
              message.body[0]['Id'], message.body[0]['Line']));
        }
      });
    } catch (e) {
      print(e); // TODO: Snackbar with error
    }
  }
}
