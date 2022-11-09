import 'dart:convert';

String actionsToJson(List<Action> actions) =>
    jsonEncode(actions.map((Action action) => action.toJson()).toList());

class Action {
  Action(
      {required this.id,
      required this.title,
      required this.description,
      this.logs = '',
      this.started = false});

  String id;
  String title;
  String description;
  String logs;
  bool started;

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        id: json['Id'],
        title: json['Title'],
        description: json['Description'],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Description": description,
      };
}
