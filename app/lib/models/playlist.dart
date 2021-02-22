import 'package:app/models/radiostation.dart';

class PlayList {
  final List<RadioStation> radioStations;
  final RadioStation lastPlayed;

  PlayList(this.radioStations, this.lastPlayed);

  PlayList.fromJson(Map<String, dynamic> data)
      : radioStations = data['radioStations'],
        lastPlayed = data['lastPlayed'];
}
