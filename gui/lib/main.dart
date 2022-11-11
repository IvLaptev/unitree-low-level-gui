import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui/bloc/minerva/minerva_bloc.dart';
import 'package:gui/bloc/motions_bloc.dart';
import 'package:gui/bloc/settings_bloc.dart';

import 'package:gui/screens/home_page.dart';
import 'package:gui/screens/minerva_page.dart';
import 'package:gui/screens/settings_page.dart';

import 'package:gui/widgets/page.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

const String appTitle = 'Robot GUI';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden,
        windowButtonVisibility: false);
    await windowManager.setSize(const Size(755, 545));
    await windowManager.setMinimumSize(const Size(654, 600));
    await windowManager.center();
    await windowManager.show();
    await windowManager.setPreventClose(true);
    await windowManager.setSkipTaskbar(false);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SettingsBloc>(create: (_) => SettingsBloc()),
        Provider<MotionsBloc>(create: (_) => MotionsBloc()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MinervaBloc>(
              create: (BuildContext context) => MinervaBloc())
        ],
        child: const FluentApp(
          debugShowCheckedModeBanner: false,
          title: appTitle,
          home: BaseLayout(),
        ),
      ),
    );
  }
}

class BaseLayout extends StatefulWidget {
  const BaseLayout({Key? key}) : super(key: key);

  @override
  _BaseLayoutState createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> with WindowListener {
  int index = 0;

  final content = <Page>[HomePage(), MinervaPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
          automaticallyImplyLeading: false,
          title: const DragToMoveArea(
              child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text('    $appTitle'),
          )),
          actions: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [WindowButtons()],
          ),
          height: 35),
      pane: NavigationPane(
          selected: index,
          onChanged: (i) {
            setState(() => index = i);
          },
          items: [
            PaneItem(
                icon: const Icon(FluentIcons.add_to_shopping_list),
                title: const Text('Motions')),
            PaneItem(
                icon: const Icon(FluentIcons.charticulator_linking_data),
                title: const Text('Minerva'))
          ],
          footerItems: [
            PaneItemSeparator(),
            PaneItem(
                icon: const Icon(FluentIcons.settings),
                title: const Text('Settings'))
          ]),
      content: NavigationBody(
        index: index,
        children: content.transform(context),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 138,
      height: 30,
      child: WindowCaption(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
