import 'dart:convert';

import 'package:gui/bloc/minerva/minerva_bloc.dart';
import 'package:gui/models/action.dart';
import 'package:gui/models/ws_message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ActionsProvider {
  WebSocketChannel? channel;
  final Function _addEvent;

  ActionsProvider(this._addEvent) {
    try {
      channel =
          WebSocketChannel.connect(Uri.parse('ws://localhost:8080/control'));

      channel!.stream.listen((msg) {
        WsMessage message = WsMessage.fromJson(json.decode(msg));

        if (message.cmd == ActionCommands.setActions) {
          _setActions(message.body);
        } else if (message.cmd == ActionCommands.stopAction) {
          _addEvent(ActionStopped(message.body[0]));
        }
      });
    } catch (e) {
      print(e); // TODO: Snackbar with error
    }
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
}
