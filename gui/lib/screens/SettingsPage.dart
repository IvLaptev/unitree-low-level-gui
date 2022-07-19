import 'package:fluent_ui/fluent_ui.dart';
import 'package:gui/widgets/page.dart';

class SettingsPage extends ScrollablePage {
  @override
  Widget buildHeader(BuildContext context) {
    return const PageHeader(title: Text('Settings'));
  }

  @override
  List<Widget> buildScrollable(BuildContext context) {
    final theme = FluentTheme.of(context);
    return [
      Text(
        'Server',
        style: theme.typography.subtitle,
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: TextBox(
          header: 'Host',
          maxLength: 15,
          placeholder: '192.168.11.12',
          placeholderStyle: theme.typography.body?.copyWith(
              fontStyle: FontStyle.italic, color: const Color(0xFFADADAD)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: TextBox(
          header: 'Port',
          maxLength: 5,
          placeholder: '8080',
          placeholderStyle: theme.typography.body?.copyWith(
              fontStyle: FontStyle.italic, color: const Color(0xFFADADAD)),
        ),
      )
    ];
  }
}
