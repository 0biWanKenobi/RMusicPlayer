import 'package:app/models/radiostation.dart';

class RadioStationX {
  final int listIndex;
  final RadioStation radioStation;

  RadioStationX(
    this.radioStation,
    this.listIndex,
  );

  RadioStationX.fromJson(dynamic data)
      : radioStation = RadioStation.fromJson(data['radioStation']),
        listIndex = data['listIndex'];

  Object toJson() {
    return {
      'radioStation': radioStation.toJson(),
      'listIndex': listIndex,
    };
  }
}
