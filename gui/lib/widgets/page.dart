import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';

int _pageIndex = -1;

abstract class Page {
  Page() {
    _pageIndex++;
  }

  final StreamController _controller = StreamController.broadcast();
  Stream get stateStream => _controller.stream;

  Widget build(BuildContext context);

  void setState(VoidCallback func) {
    func();
    _controller.add(null);
  }
}

abstract class ScrollablePage extends Page {
  ScrollablePage() : super();

  final scrollController = ScrollController();
  Widget buildHeader(BuildContext context) => const SizedBox.shrink();

  Widget builderBottomBar(BuildContext context) => const SizedBox.shrink();

  List<Widget> buildScrollable(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      key: PageStorageKey(_pageIndex),
      scrollController: scrollController,
      header: buildHeader(context),
      bottomBar: builderBottomBar(context),
      children: buildScrollable(context),
    );
  }
}

class EmptyPage extends Page {
  final Widget? child;

  EmptyPage([this.child]);

  @override
  Widget build(BuildContext context) {
    return child ?? const SizedBox.shrink();
  }
}

extension PageExtension on List<Page> {
  List<Widget> transform(BuildContext context) {
    return map((page) {
      return StreamBuilder(
        stream: page.stateStream,
        builder: (context, _) {
          return page.build(context);
        },
      );
    }).toList();
  }
}

extension WidgetPageExtention on Widget {
  Page toPage() {
    return EmptyPage(this);
  }
}
