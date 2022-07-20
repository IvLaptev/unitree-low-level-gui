import 'package:fluent_ui/fluent_ui.dart';
import 'package:gui/bloc/SettingsBloc.dart';
import 'package:gui/widgets/page.dart';
import 'package:provider/provider.dart';

class SettingsPage extends ScrollablePage {
  @override
  Widget buildHeader(BuildContext context) {
    return const PageHeader(title: Text('Settings'));
  }

  @override
  List<Widget> buildScrollable(BuildContext context) {
    final theme = FluentTheme.of(context);
    final bloc = Provider.of<SettingsBloc>(context);

    return [
      Text(
        'Server',
        style: theme.typography.subtitle,
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: StreamBuilder(
            stream: bloc.settings,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return TextFormBox(
                  header: 'Host',
                  initialValue: snapshot.data.ip,
                  maxLength: 15,
                  onChanged: (data) {
                    snapshot.data.ip = data;
                    bloc.changeSettings.add(snapshot.data);
                  },
                  placeholder: '192.168.11.12',
                  placeholderStyle: theme.typography.body?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFFADADAD)),
                );
              }

              return const Text('data');
            }),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: StreamBuilder(
          stream: bloc.settings,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return TextFormBox(
                header: 'Port',
                initialValue: snapshot.data.port,
                maxLength: 5,
                onChanged: (data) {
                  snapshot.data.port = data;
                  bloc.changeSettings.add(snapshot.data);
                },
                placeholder: '8080',
                placeholderStyle: theme.typography.body?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFFADADAD)),
              );
            }
            return const Text('');
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: StreamBuilder(
          stream: bloc.settings,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return TextFormBox(
                initialValue: snapshot.data.secret,
                header: 'Secret',
                enabled: false,
              );
            }
            return const Text('');
          },
        ),
      )
    ];
  }
}
