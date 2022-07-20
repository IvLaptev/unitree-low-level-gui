import 'dart:async';

import 'package:rxdart/rxdart.dart';

class Motion {
  int leg = 0;
  int startTime = 0;
  int duration = 0;

  double q = 0;
  double dq = 0;
  double tau = 0;
  double kp = 0;
  double kd = 0;
}

class MotionsBloc {
  List<Motion> _motions = <Motion>[];

  MotionsBloc() {
    _motions = <Motion>[];
    _actionController.stream.listen(changeStream);
    _setValue.add(_motions);
  }

  final _motionsStream = BehaviorSubject<List<Motion>>.seeded(<Motion>[]);

  Stream get motions => _motionsStream.stream;
  Sink get _setValue => _motionsStream.sink;

  StreamController _actionController = StreamController<List<Motion>>();
  StreamSink get changeMotions => _actionController.sink;

  void changeStream(data) async {
    _motions = data;
    _setValue.add(_motions);
  }

  void dispose() {
    _actionController.close();
    _motionsStream.close();
  }
}
