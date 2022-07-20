import 'package:fluent_ui/fluent_ui.dart';
import 'package:gui/widgets/page.dart';

class HomePage extends ScrollablePage {
  @override
  Widget buildHeader(BuildContext context) {
    return PageHeader(
      title: const Text('Fluent UI for Flutter Showcase App'),
      commandBar: Row(children: const [Text('Source code')]),
    );
  }

  bool selected = true;

  @override
  List<Widget> buildScrollable(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);
    return [
      Card(
        child: Wrap(alignment: WrapAlignment.center, spacing: 10.0, children: [
          InfoLabel(
            label: 'Inputs',
            child: ToggleSwitch(
              checked: selected,
              onChanged: (v) => setState(() => selected = v),
            ),
          ),
          const RepaintBoundary(
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 4.0),
              child: InfoLabel(
                label: 'Progress',
                child: SizedBox(height: 30, width: 30, child: ProgressRing()),
              ),
            ),
          ),
          InfoLabel(
            label: 'Surfaces & Materials',
            child: SizedBox(
              height: 40,
              width: 120,
              child: Stack(children: [
                Container(width: 25, height: 50, color: Colors.blue.lightest),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 25,
                    height: 50,
                    color: Colors.blue.lightest,
                  ),
                ),
                const Positioned.fill(child: Acrylic(luminosityAlpha: 0.5)),
              ]),
            ),
          ),
          const InfoLabel(
            label: 'Icons',
            child: Icon(FluentIcons.graph_symbol, size: 30.0),
          ),
          InfoLabel(
            label: 'Colors',
            child: SizedBox(
              width: 40,
              height: 30,
              child: Wrap(
                children: <Color>[
                  ...Colors.accentColors,
                  Colors.successPrimaryColor,
                  Colors.warningPrimaryColor,
                  Colors.errorPrimaryColor,
                  Colors.grey,
                ].map((color) {
                  return Container(
                    height: 10,
                    width: 10,
                    color: color,
                  );
                }).toList(),
              ),
            ),
          ),
          InfoLabel(
            label: 'Typography',
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  colors: [
                    Colors.white,
                    ...Colors.accentColors,
                  ],
                ).createShader(rect);
              },
              blendMode: BlendMode.srcATop,
              child: const Text(
                'ABCDEFGH',
                style: TextStyle(fontSize: 24, shadows: [
                  Shadow(offset: Offset(1, 1)),
                ]),
              ),
            ),
          ),
        ]),
      ),
      const SizedBox(height: 22.0),
      IconButton(
        onPressed: () {},
        icon: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What\'s new on 4.0.0',
              style:
                  theme.typography.body?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text('June 21, 2022', style: theme.typography.caption),
            Text(
              'A native look-and-feel out of the box',
              style: theme.typography.bodyLarge,
            ),
          ],
        ),
      ),
      const SizedBox(height: 22.0),
      Row(children: [
        Text('SPONSORS', style: theme.typography.bodyStrong),
        const SizedBox(width: 4.0),
        const Icon(FluentIcons.heart_fill, size: 16.0),
      ]),
      const SizedBox(height: 4.0),
    ];
  }
}
