import 'dart:convert';
import 'dart:io';

import 'package:app/models/api_error.dart';
import 'package:app/models/playlist.dart';
import 'package:app/models/radiostation_x.dart';
import 'package:either_option/either_option.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class RadioControlService extends StateNotifier<bool> {
  final String radioIp;

  RadioControlService(bool state, {this.radioIp}) : super(state);

  bool get playing => state;

  Future<Either<ApiError, bool>> play() async {
    try {
      final response = await http.post('http://$radioIp:8000/play');
      if (response.statusCode != HttpStatus.ok)
        return Left(ApiError('Errore avvio riproduzione',
            'RadioControlService.play: status ${response.statusCode}'));

      state = true;
      return Right(true);
    } catch (e) {
      return Left(ApiError('Eccezione in avvio riproduzione',
          'RadioControlService.play: status ${e.message}'));
    }
  }

  Future<Either<ApiError, bool>> pause() async {
    try {
      final response = await http.post('http://$radioIp:8000/pause');
      if (response.statusCode != HttpStatus.ok)
        return Left(ApiError('Errore arresto riproduzione',
            'RadioControlService.pause: status ${response.statusCode}'));

      state = false;
      return Right(true);
    } catch (e) {
      return Left(ApiError('Eccezione in avvio riproduzione',
          'RadioControlService.pause: status ${e.message}'));
    }
  }

  Future<Either<ApiError, bool>> playChannel(RadioStationX radioStation) async {
    try {
      final body = json.encode(radioStation);
      final response =
          await http.post('http://$radioIp:8000/play_channel', body: body);
      if (response.statusCode != HttpStatus.ok)
        return Left(ApiError('Errore arresto riproduzione',
            'RadioControlService.pause: status ${response.statusCode}'));

      state = true;
      return Right(true);
    } catch (e) {
      return Left(ApiError('Eccezione in avvio riproduzione',
          'RadioControlService.pause: status ${e.message}'));
    }
  }

  String generateRadioImage(String imageName) {
    return "http://$radioIp:8000/$imageName";
  }

  Future<Either<ApiError, PlayList>> getPlaylist() async {
    try {
      final response = await http.post('http://$radioIp:8000/requestPlaylist');
      if (response.statusCode != HttpStatus.ok)
        return Left(ApiError('Errore in recupero playlist',
            'RadioControlService.getPlaylist: status ${response.statusCode}'));

      return Right(PlayList.fromJson(json.decode(response.body)));
    } catch (e) {
      return Left(ApiError('Eccezione in recupero playlist',
          'RadioControlService.getPlaylist: status $e'));
    }
  }
}
