import 'package:intl/intl.dart';

class StepsDataModel {
  DateTime? time;
  int? stepsCount;

  StepsDataModel({String? time, this.stepsCount})
      : time = DateFormat('yyyy-MM-dd').parse(time!);

  factory StepsDataModel.fromJson(map) {
    return StepsDataModel(
      time: map['time'],
      stepsCount: map['stepsCount'] ?? 0,
    );
  }
  toJson() {
    return {
      "time": time.toString(),
      "stepsCount": stepsCount,
    };
  }
}

List<StepsDataModel> steps = [
  StepsDataModel(time: '2023-03-10 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-11 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-12 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-13 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-14 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-15 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-16 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-17 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-18 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-19 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-20 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-21 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-22 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-23 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-24 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-25 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-26 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-27 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-28 ', stepsCount: 500),
  StepsDataModel(time: '2023-03-29 ', stepsCount: 1111),
  StepsDataModel(time: '2023-03-30 ', stepsCount: 2313),
  StepsDataModel(time: '2023-03-31 ', stepsCount: 1124),
  StepsDataModel(time: '2023-04-01 ', stepsCount: 1365),
  StepsDataModel(time: '2023-04-02 ', stepsCount: 1265),
  StepsDataModel(time: '2023-04-03 ', stepsCount: 1176),
  StepsDataModel(time: '2023-04-04 ', stepsCount: 935),
  StepsDataModel(time: '2023-04-05 ', stepsCount: 458),
  StepsDataModel(time: '2023-04-06 ', stepsCount: 1164),
  StepsDataModel(time: '2023-04-07 ', stepsCount: 3551),
  StepsDataModel(time: '2023-04-08 ', stepsCount: 656),
  StepsDataModel(time: '2023-04-09 ', stepsCount: 5145),
  StepsDataModel(time: '2023-04-10 ', stepsCount: 2165),
  StepsDataModel(time: '2023-04-11 ', stepsCount: 3105),
  StepsDataModel(time: '2023-04-12 ', stepsCount: 3045),
  StepsDataModel(time: '2023-04-13 ', stepsCount: 3000),
  StepsDataModel(time: '2023-04-14 ', stepsCount: 2565),
  StepsDataModel(time: '2023-04-15 ', stepsCount: 3000),
  StepsDataModel(time: '2023-04-16 ', stepsCount: 1197),
  StepsDataModel(time: '2023-04-17 ', stepsCount: 2506),
  StepsDataModel(time: '2023-04-18 ', stepsCount: 2301),
  StepsDataModel(time: '2023-04-19 ', stepsCount: 2201),
  StepsDataModel(time: '2023-04-20 ', stepsCount: 1758),
  StepsDataModel(time: '2023-04-21 ', stepsCount: 1375),
  StepsDataModel(time: '2023-04-22 ', stepsCount: 1165),
  StepsDataModel(time: '2023-04-23 ', stepsCount: 1121),
  StepsDataModel(time: '2023-04-24 ', stepsCount: 443),
  StepsDataModel(time: '2023-04-25 ', stepsCount: 651),
  StepsDataModel(time: '2023-04-26 ', stepsCount: 550),
  StepsDataModel(time: '2023-04-27 ', stepsCount: 220),
];
