enum ActionCommands {
  setActions('actions.set'),
  getActions('actions.get'),
  startAction('action.start'),
  stopAction('action.stop');

  const ActionCommands(this.message);

  factory ActionCommands.fromString(String msg) {
    ActionCommands? elem;
    for (var element in ActionCommands.values) {
      if (element.message == msg) {
        elem = element;
      }
    }

    if (elem != null) {
      return elem;
    } else {
      throw Error();
    }
  }
  final String message;
}

// String motionsToJson(List<Motion> motions) =>
//     jsonEncode(motions.map((Motion motion) => motion.toJson()).toList());

class WsMessage {
  ActionCommands cmd;
  List<dynamic> body;

  WsMessage({this.cmd = ActionCommands.setActions, this.body = const []});

  factory WsMessage.fromJson(Map<String, dynamic> json) => WsMessage(
      cmd: ActionCommands.fromString(json["Command"]), body: json["Body"]);

  Map<String, dynamic> toJson() => {
        "command": cmd.message,
        "body": body,
      };
}
