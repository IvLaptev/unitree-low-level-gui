import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui/bloc/motions/motions_bloc.dart';
import 'package:gui/models/motion.dart';
import 'package:gui/widgets/motion_input.dart';
import 'package:gui/widgets/page.dart';

class HomePage extends ScrollablePage {
  @override
  Widget buildHeader(BuildContext context) {
    return BlocConsumer<MotionsBloc, MotionsState>(listener: (context, state) {
      if (state.snackbarText != null) {
        _showMessage(context, state.snackbarText!);
      }
    }, builder: (BuildContext context, MotionsState state) {
      return PageHeader(
        title: const Text('Motions'),
        commandBar: Row(children: [
          Button(
              child: const Icon(
                FluentIcons.chrome_close,
                size: 18.0,
              ),
              onPressed: () =>
                  context.read<MotionsBloc>().add(MotionsCleared())),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
            child: Button(
                child: const Icon(
                  FluentIcons.add,
                  size: 18.0,
                ),
                onPressed: () =>
                    context.read<MotionsBloc>().add(MotionAdded(Motion()))),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
            child: Button(
                child: const Icon(
                  FluentIcons.play,
                  size: 18.0,
                ),
                onPressed: () =>
                    context.read<MotionsBloc>().add(MotionsSent())),
          )
        ]),
      );
    });
  }

  bool selected = true;

  @override
  List<Widget> buildScrollable(BuildContext context) {
    return [
      BlocBuilder<MotionsBloc, MotionsState>(
          builder: (BuildContext context, MotionsState state) {
        List<Widget> widgets = state.motions
            .asMap()
            .entries
            .map((motion) => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Expander(
                      contentBackgroundColor: const Color(0xFFFFFFFF),
                      header: Text(
                          'Leg: ${motion.value.leg}    |    Start time: ${motion.value.startTime}    |    Duration: ${motion.value.duration}'),
                      content: MotionInput(
                        motion: motion.value,
                        onChange: (Motion newMotion) => context
                            .read<MotionsBloc>()
                            .add(MotionChanged(newMotion, motion.key)),
                      )),
                ))
            .toList();

        return Column(
          children: widgets,
        );
      })
    ];
  }

  _showMessage(BuildContext context, String text) {
    print(text);
    showSnackbar(context, Snackbar(extended: true, content: Text(text)));
  }
}
