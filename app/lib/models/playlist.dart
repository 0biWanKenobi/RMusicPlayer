import 'package:app/models/radiostation.dart';

class PlayList {
  final List<RadioStation> radioStations;
  final RadioStation lastPlayed;

  PlayList(this.radioStations, this.lastPlayed);

  PlayList.fromJson(Map<String, dynamic> data)
      : radioStations = (data['shoutcast'] as List)
            .map((radioStation) => RadioStation.fromJson(radioStation))
            .toList(),
        lastPlayed = RadioStation.fromJson(data['last_played']);
}
