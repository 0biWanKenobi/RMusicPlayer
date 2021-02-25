import 'package:app/models/radiostation.dart';
import 'package:app/models/radiostation_x.dart';

class PlayList {
  final List<RadioStation> radioStations;
  final RadioStationX lastPlayed;

  PlayList(this.radioStations, this.lastPlayed);

  PlayList.fromJson(Map<String, dynamic> data)
      : radioStations = (data['shoutcast'] as List)
            .map((radioStation) => RadioStation.fromJson(radioStation))
            .toList(),
        lastPlayed =
            data.containsKey('last_played') && data['last_played'] != null
                ? RadioStationX.fromJson(data['last_played'])
                : null;
}
