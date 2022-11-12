import 'package:fluent_ui/fluent_ui.dart';
import 'package:gui/models/motion.dart';

class MotionInput extends StatelessWidget {
  const MotionInput({required this.motion, this.onChange, Key? key})
      : super(key: key);

  final Motion motion;
  final Function? onChange;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Flex(
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
              initialValue: motion.leg.toString(),
              onChanged: (data) {
                var newMotion = motion.copyOf();
                newMotion.leg = int.tryParse(data) ?? 0;
                if (onChange != null) onChange!(newMotion);
              },
            )),
            Expanded(
                child: TextFormBox(
              header: 'Start time',
              initialValue: motion.startTime.toString(),
              onChanged: (data) {
                var newMotion = motion.copyOf();
                newMotion.startTime = int.tryParse(data) ?? 0;
                if (onChange != null) onChange!(newMotion);
              },
            )),
            Expanded(
                child: TextFormBox(
              header: 'Duration',
              initialValue: motion.duration.toString(),
              onChanged: (data) {
                var newMotion = motion.copyOf();
                newMotion.duration = int.tryParse(data) ?? 0;
                if (onChange != null) onChange!(newMotion);
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
              initialValue: motion.q.toString(),
              onChanged: (data) {
                var newMotion = motion.copyOf();
                newMotion.q = double.tryParse(data) ?? 0;
                if (onChange != null) onChange!(newMotion);
              },
            )),
            Expanded(
                child: TextFormBox(
              header: 'dq',
              initialValue: motion.dq.toString(),
              onChanged: (data) {
                var newMotion = motion.copyOf();
                newMotion.dq = double.tryParse(data) ?? 0;
                if (onChange != null) onChange!(newMotion);
              },
            )),
            Expanded(
                child: TextFormBox(
              header: 'tau',
              initialValue: motion.tau.toString(),
              onChanged: (data) {
                var newMotion = motion.copyOf();
                newMotion.tau = double.tryParse(data) ?? 0;
                if (onChange != null) onChange!(newMotion);
              },
            )),
            Expanded(
                child: TextFormBox(
              header: 'kp',
              initialValue: motion.kp.toString(),
              onChanged: (data) {
                var newMotion = motion.copyOf();
                newMotion.kp = double.tryParse(data) ?? 0;
                if (onChange != null) onChange!(newMotion);
              },
            )),
            Expanded(
                child: TextFormBox(
              header: 'kd',
              initialValue: motion.kd.toString(),
              onChanged: (data) {
                var newMotion = motion.copyOf();
                newMotion.kd = double.tryParse(data) ?? 0;
                if (onChange != null) onChange!(newMotion);
              },
            )),
          ],
        )
      ],
    );
  }
}
