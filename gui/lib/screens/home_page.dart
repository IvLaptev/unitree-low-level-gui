import 'package:fluent_ui/fluent_ui.dart';
import 'package:gui/bloc/motions_bloc.dart';
import 'package:gui/models/motion.dart';
import 'package:gui/resources/api_provider.dart';
import 'package:gui/widgets/page.dart';
import 'package:provider/provider.dart';

class HomePage extends ScrollablePage {
  @override
  Widget buildHeader(BuildContext context) {
    MotionsBloc bloc = Provider.of<MotionsBloc>(context);

    return StreamBuilder(
        stream: bloc.motions,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return PageHeader(
            title: const Text('Motions'),
            commandBar: Row(children: [
              Button(
                  child: const Icon(
                    FluentIcons.chrome_close,
                    size: 18.0,
                  ),
                  onPressed: () {
                    bloc.changeMotions.add(<Motion>[]);
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                child: Button(
                    child: const Icon(
                      FluentIcons.add,
                      size: 18.0,
                    ),
                    onPressed: () {
                      snapshot.data.add(Motion());
                      bloc.changeMotions.add(snapshot.data);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                child: Button(
                    child: const Icon(
                      FluentIcons.play,
                      size: 18.0,
                    ),
                    onPressed: () {
                      ApiProvider.sendMotions(snapshot.data)
                          .then((_) => showSnackbar(
                              context,
                              const Snackbar(
                                  extended: true,
                                  content: Text('Successfully sent'))))
                          .catchError((e) => showSnackbar(context,
                              Snackbar(extended: true, content: Text(e))));
                    }),
              )
            ]),
          );
        });
  }

  bool selected = true;

  @override
  List<Widget> buildScrollable(BuildContext context) {
    MotionsBloc bloc = Provider.of<MotionsBloc>(context);
    final theme = FluentTheme.of(context);

    return [
      StreamBuilder(
          stream: bloc.motions,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              List<Widget> widgets = <Widget>[];
              List<Motion> motions = snapshot.data;

              for (int i = 0; i < motions.length; i++) {
                widgets.add(Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Expander(
                      header: Text(
                          'Leg: ${motions[i].leg}    |    Start time: ${motions[i].startTime}    |    Duration: ${motions[i].duration}'),
                      content: Flex(
                        direction: Axis.vertical,
                        children: [
                          Row(children: [
                            Text(
                              'General',
                              style: theme.typography.bodyStrong,
                            )
                          ]),
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormBox(
                                header: 'Leg',
                                initialValue: motions[i].leg.toString(),
                                onChanged: (data) {
                                  motions[i].leg = int.tryParse(data) ?? 0;
                                  bloc.changeMotions.add(motions);
                                },
                              )),
                              Expanded(
                                  child: TextFormBox(
                                header: 'Start time',
                                initialValue: motions[i].startTime.toString(),
                                onChanged: (data) {
                                  motions[i].startTime =
                                      int.tryParse(data) ?? 0;
                                  bloc.changeMotions.add(motions);
                                },
                              )),
                              Expanded(
                                  child: TextFormBox(
                                header: 'Duration',
                                initialValue: motions[i].duration.toString(),
                                onChanged: (data) {
                                  motions[i].duration = int.tryParse(data) ?? 0;
                                  bloc.changeMotions.add(motions);
                                },
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Position',
                                style: theme.typography.bodyStrong,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormBox(
                                header: 'q',
                                initialValue: motions[i].leg.toString(),
                                onChanged: (data) {
                                  motions[i].q = double.tryParse(data) ?? 0;
                                  bloc.changeMotions.add(motions);
                                },
                              )),
                              Expanded(
                                  child: TextFormBox(
                                header: 'dq',
                                initialValue: motions[i].leg.toString(),
                                onChanged: (data) {
                                  motions[i].dq = double.tryParse(data) ?? 0;
                                  bloc.changeMotions.add(motions);
                                },
                              )),
                              Expanded(
                                  child: TextFormBox(
                                header: 'tau',
                                initialValue: motions[i].leg.toString(),
                                onChanged: (data) {
                                  motions[i].tau = double.tryParse(data) ?? 0;
                                  bloc.changeMotions.add(motions);
                                },
                              )),
                              Expanded(
                                  child: TextFormBox(
                                header: 'kp',
                                initialValue: motions[i].leg.toString(),
                                onChanged: (data) {
                                  motions[i].kp = double.tryParse(data) ?? 0;
                                  bloc.changeMotions.add(motions);
                                },
                              )),
                              Expanded(
                                  child: TextFormBox(
                                header: 'kd',
                                initialValue: motions[i].leg.toString(),
                                onChanged: (data) {
                                  motions[i].kd = double.tryParse(data) ?? 0;
                                  bloc.changeMotions.add(motions);
                                },
                              )),
                            ],
                          )
                        ],
                      )),
                ));
              }

              return Column(
                children: widgets,
              );
            }
            return const Text('Wait for some time');
          })
    ];
  }
}
