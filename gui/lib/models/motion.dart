import 'dart:convert';

String motionsToJson(List<Motion> motions) =>
    jsonEncode(motions.map((Motion motion) => motion.toJson()).toList());

class Motion {
  int leg = 0;
  int startTime = 0;
  int duration = 0;

  double q = 0;
  double dq = 0;
  double tau = 0;
  double kp = 0;
  double kd = 0;

  Motion({
    this.leg = 0,
    this.startTime = 0,
    this.duration = 0,
    this.q = 0,
    this.dq = 0,
    this.tau = 0,
    this.kp = 0,
    this.kd = 0,
  });

  factory Motion.fromJson(Map<String, dynamic> json) => Motion(
        leg: json["leg"],
        startTime: json["start_time"],
        duration: json["duration"],
        q: json["q"].toDouble(),
        dq: json["dq"].toDouble(),
        tau: json["tau"].toDouble(),
        kp: json["kd"].toDouble(),
        kd: json["kp"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "leg": leg,
        "start_time": startTime,
        "duration": duration,
        "q": q,
        "dq": dq,
        "tau": tau,
        "kp": kp,
        "kd": kd,
      };
}
