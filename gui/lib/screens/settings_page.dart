import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui/bloc/minerva/minerva_bloc.dart';
import 'package:gui/bloc/settings/settings_bloc.dart';
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
        child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (BuildContext context, SettingsState state) => TextFormBox(
                  header: 'API URL',
                  initialValue: state.apiUrl,
                  onChanged: (url) {
                    context.read<SettingsBloc>().add(ApiUrlChanged(url));
                  },
                  placeholder: '192.168.11.12:8080',
                  placeholderStyle: theme.typography.body?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFFADADAD)),
                )),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: BlocConsumer<SettingsBloc, SettingsState>(
            listener: (context, state) {
              BlocProvider.of<MinervaBloc>(context)
                  .add(UrlChanged(state.minervaUrl));
            },
            builder: (BuildContext context, SettingsState state) => TextFormBox(
                  header: 'Minerva URL',
                  initialValue: state.minervaUrl,
                  onChanged: (url) {
                    context.read<SettingsBloc>().add(MinervaUrlChanged(url));
                  },
                  placeholder: '8080',
                  placeholderStyle: theme.typography.body?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFFADADAD)),
                )),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (BuildContext context, SettingsState state) => TextFormBox(
                  initialValue: state.secret,
                  header: 'Secret',
                  enabled: false,
                )),
      )
    ];
  }
}
