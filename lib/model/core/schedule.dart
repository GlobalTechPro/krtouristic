import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  Schedule({
    required this.weekDay,
    required this.fromHour,
    required this.fromMinute,
    required this.toHour,
    required this.toMinute,
  }) {
    duration = Duration(
      hours: (toHour - fromHour).abs(),
      minutes: (toMinute - fromMinute).abs(),
    );
  }

  String weekDay;
  int fromHour;
  int fromMinute;
  int toHour;
  int toMinute;
  Duration? duration;

  factory Schedule.fromFirestore(
    dynamic snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data;
    if (snapshot is DocumentSnapshot<Map<String, dynamic>>) {
      data = snapshot.data();
    } else {
      data = snapshot;
    }
    return Schedule(
      weekDay: data?['week_day'],
      fromHour: data?['from_hour'],
      fromMinute: data?['from_minute'],
      toHour: data?['to_hour'],
      toMinute: data?['to_minute'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "week_day": weekDay,
      "from_hour": fromHour,
      "from_minute": fromMinute,
      "to_hour": toHour,
      "to_minute": toMinute,
    };
  }
}
