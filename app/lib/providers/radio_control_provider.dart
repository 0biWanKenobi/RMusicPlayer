import 'package:app/models/radiostation_x.dart';
import 'package:app/pages/home/playlist_widget.dart';
import 'package:app/providers/connection_status_provider.dart';
import 'package:app/providers/remote_device_ip_provider.dart';
import 'package:app/services/radio_control_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final radioControlProvider = StateNotifierProvider<RadioControlService>((ref) {
  final ip = ref.watch(remoteIpProvider.state);
  return RadioControlService(false, radioIp: ip);
});

final userSelectedRadioProvider = StateProvider<RadioStationX>((ref) => null);

final lastPlayedRadioProvider = Provider<RadioStationX>((ref) {
  final lastOnRemote = ref
      .watch(radioListProvider)
      .data
      ?.value
      ?.fold((_) => null, (list) => list.lastPlayed);
  final lastLocal = ref.watch(userSelectedRadioProvider).state;
  return lastLocal ?? lastOnRemote;
});

final canChangeStationProvider = Provider<bool>((ref) {
  final connected = ref.watch(connectionStatusProvider.state);
  final availableRadios =
      ref.watch(radioListProvider).data?.value?.isRight ?? false;
  return connected && availableRadios;
});
