import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:gui/bloc/SettingsBloc.dart';
import 'package:gui/screens/HomePage.dart';
import 'package:gui/screens/SettingsPage.dart';
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
        Provider<SettingsBloc>(
          create: (_) => SettingsBloc(),
        )
      ],
      child: const FluentApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        home: BaseLayout(),
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

  final content = <Page>[HomePage(), SettingsPage()];

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
                title: const Text('Motions'))
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

// void main() {
//   runApp(const MyApp());

//   doWhenWindowReady(() {
//     final win = appWindow;
//     const initialSize = Size(600, 450);
//     win.minSize = initialSize;
//     win.size = initialSize;
//     win.alignment = Alignment.center;
//     win.title = "Robot GUI";
//     win.show();
//   });
// }

// const borderColor = Color.fromARGB(0, 50, 189, 207);

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return FluentApp(
//       title: 'Robot GUI',
//       debugShowCheckedModeBanner: false,
//       home: NavigationView(
//         appBar: NavigationAppBar(
//           title: Container(
//             color: const Color(0xffe9ebec),
//             child: Row(children: [
//               Expanded(child: MoveWindow()),
//               const WindowButtons()
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Windows bar buttons settings

// final buttonColors = WindowButtonColors(
//     iconNormal: const Color(0xFF444444),
//     mouseOver: const Color(0xFFD0D2D5),
//     mouseDown: const Color(0xFFB2B4B8),
//     iconMouseOver: const Color(0xFF000000),
//     iconMouseDown: const Color(0xFF000000));

// final closeButtonColors = WindowButtonColors(
//     iconNormal: const Color(0xFF444444),
//     mouseOver: const Color(0xFFe81123),
//     mouseDown: const Color(0xFFE36571),
//     iconMouseOver: const Color(0xFFFFFFFF),
//     iconMouseDown: const Color(0xFFFFFFFF));

// class WindowButtons extends StatefulWidget {
//   const WindowButtons({Key? key}) : super(key: key);

//   @override
//   _WindowButtonState createState() => _WindowButtonState();
// }

// class _WindowButtonState extends State<WindowButtons> {
//   void maximizeOrRestore() {
//     setState(() {
//       appWindow.maximizeOrRestore();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         MinimizeWindowButton(
//           colors: buttonColors,
//         ),
//         appWindow.isMaximized
//             ? RestoreWindowButton(
//                 colors: buttonColors,
//                 onPressed: maximizeOrRestore,
//               )
//             : MaximizeWindowButton(
//                 colors: buttonColors,
//                 onPressed: maximizeOrRestore,
//               ),
//         CloseWindowButton(
//           colors: closeButtonColors,
//         )
//       ],
//     );
//   }
// }
