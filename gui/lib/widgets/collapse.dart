import 'package:fluent_ui/fluent_ui.dart';

class Collapse extends StatelessWidget {
  const Collapse({
    required this.title,
    required this.body,
    this.actions = const [],
    Key? key,
  }) : super(key: key);

  final Widget title;
  final List<Widget> actions;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: Expander(
          contentBackgroundColor: const Color(0xFFFFFFFF),
          header: Row(
            children: [title, const Spacer(), ...actions],
          ),
          content: body),
    );
  }
}
