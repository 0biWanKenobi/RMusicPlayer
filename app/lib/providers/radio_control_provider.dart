import 'package:app/providers/remote_device_ip_provider.dart';
import 'package:app/services/radio_control_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final radioControlProvider = StateNotifierProvider<RadioControlService>((ref) {
  final ip = ref.watch(remoteIpProvider.state);
  return RadioControlService(false, radioIp: ip);
});
