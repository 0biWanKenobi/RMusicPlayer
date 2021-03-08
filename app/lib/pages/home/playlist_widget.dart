import 'package:app/models/radiostation.dart';
import 'package:app/models/radiostation_x.dart';
import 'package:app/providers/connection_status_provider.dart';
import 'package:app/providers/radio_control_provider.dart'
    show radioControlProvider, userSelectedRadioProvider;
import 'package:app/providers/remote_device_ip_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _deviceOffline =
    "Nessun dispositivo radio individuato. Lista radio non disponibile..";
const _loading = "Caricamento lista radio..";
const _error = "Errore di connessione. Lista radio non disponibile.";

final canShowPlaylistProvider = Provider<AsyncValue<bool>>((ref) {
  final connected = ref.watch(remoteConnectionProvider).data?.value ?? false;
  final connectionAlive = ref.watch(connectionStatusProvider.state);
  return AsyncValue.data(connectionAlive && connected);
});

class PlaylistWidget extends HookWidget {
  const PlaylistWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connected = useProvider(canShowPlaylistProvider);
    return connected.map(
      data: (result) => result.value
          ? _RadioListWidget()
          : Center(
              child: const Text(_deviceOffline, textAlign: TextAlign.center)),
      loading: (_) => Center(child: const Text(_loading)),
      error: (_) =>
          Center(child: const Text(_error, textAlign: TextAlign.center)),
    );
  }
}

final radioListProvider =
    FutureProvider((ref) => ref.watch(radioControlProvider).getPlaylist());

class _RadioListWidget extends HookWidget {
  const _RadioListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radioListAsync = useProvider(radioListProvider);
    final radioService = useProvider(radioControlProvider);

    Future<void> _playRadio(
        BuildContext context, RadioStation radio, int listIndex) async {
      final radioStationX = RadioStationX(radio, listIndex);
      context.read(userSelectedRadioProvider).state = radioStationX;
      await radioService.playChannel(radioStationX);
    }

    return radioListAsync.map(
      data: (result) => result.value.fold((error) {
        print(error.origin);
        print(error.humanReadableMsg);
        return Center(
          child: Text(
              "Risposta imprevista. Impossibile visualizzare lista radio."),
        );
      },
          (playlist) => ListView.builder(
                itemBuilder: (context, index) {
                  final radio = playlist.radioStations[index];
                  return ListTile(
                    leading: Image.network(
                      radioService.generateRadioImage(radio.image),
                      fit: BoxFit.cover,
                    ),
                    title: Text(radio.radioName),
                    trailing: FlatButton(
                      onPressed: () async =>
                          await _playRadio(context, radio, index),
                      child: Icon(Icons.play_arrow),
                    ),
                  );
                },
                itemCount: playlist.radioStations.length,
              )),
      loading: (_) => Center(
        child: Text("Richiesta elenco radio inviata.."),
      ),
      error: (_) => Offstage(),
    );
  }
}
