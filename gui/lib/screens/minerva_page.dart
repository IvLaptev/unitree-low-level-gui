import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui/bloc/minerva/minerva_bloc.dart';
import 'package:gui/widgets/collapse.dart';
import 'package:gui/widgets/log_box.dart';
import 'package:gui/widgets/page.dart';

class MinervaPage extends ScrollablePage {
  @override
  Widget buildHeader(BuildContext context) {
    return PageHeader(
      title: const Text('Minerva control'),
      commandBar: Row(children: [
        Tooltip(
          message: 'Minerva logs',
          child: Button(
              child: const Icon(
                FluentIcons.repair,
                size: 18.0,
              ),
              onPressed: () {
                _restoreActions(context);
              }),
        ),
        const SizedBox(width: 4),
        Tooltip(
          message: 'Refresh actions',
          child: Button(
              child: const Icon(
                FluentIcons.update_restore,
                size: 18.0,
              ),
              onPressed: () {
                _restoreActions(context);
              }),
        ),
      ]),
    );
  }

  @override
  List<Widget> buildScrollable(BuildContext context) {
    return [
      BlocBuilder<MinervaBloc, MinervaState>(
        builder: (context, state) {
          if (state.actions.isNotEmpty) {
            List<Widget> actions = state.actions.map((action) {
              return Collapse(
                  title: Text(action.title),
                  actions: [
                    Button(
                      child: Icon(
                        action.started ? FluentIcons.stop : FluentIcons.play,
                        size: 18.0,
                        color: action.started
                            ? const Color(0xFF3d4af1)
                            : Colors.black,
                      ),
                      onPressed: () {
                        context.read<MinervaBloc>().add(action.started
                            ? ActionStopped(action.id)
                            : ActionStarted(action.id));
                      },
                    )
                  ],
                  body: Flex(
                    direction: Axis.vertical,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description: ${action.description}'),
                            const SizedBox(
                              height: 12,
                            ),
                            LogBox(content: action.logs.join('\n'))
                          ]),
                    ],
                  ));
            }).toList();
            return Column(
              children: actions,
            );
          } else {
            _restoreActions(context);
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ProgressRing(
                  semanticLabel: 'Loading actions...',
                  activeColor: Color(0xFF3d4af1),
                )
              ],
            );
          }
        },
      )
    ];
  }

  void _restoreActions(BuildContext context) {
    BlocProvider.of<MinervaBloc>(context).add(ActionsRequested());
  }
}
