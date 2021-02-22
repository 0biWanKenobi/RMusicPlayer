import 'dart:convert';
import 'dart:io';

import 'package:app/models/api_error.dart';
import 'package:app/models/playlist.dart';
import 'package:either_option/either_option.dart';
import 'package:http/http.dart' as http;

class RadioControlService {
  String _radioDeviceIp;

  void init(String radioDeviceIp) {
    _radioDeviceIp = radioDeviceIp;
  }

  void play() {}
  void pause() {}
  Future<Either<ApiError, PlayList>> getPlaylist() async {
    try {
      final response = await http.post('$_radioDeviceIp/requestPlaylist');
      if (response.statusCode != HttpStatus.ok)
        return Left(ApiError('Errore in recupero playlist',
            'RadioControlService.getPlaylist: status ${response.statusCode}'));

      return Right(PlayList.fromJson(json.decode(response.body)));
    } catch (e) {
      return Left(ApiError('Eccezione in recupero playlist',
          'RadioControlService.getPlaylist: status ${e.message}'));
    }
  }
}
