import 'package:app/providers/remote_device_ip_provider.dart';
import 'package:app/services/connection_status_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final connectionStatusProvider =
    StateNotifierProvider<ConnectionStatusService>((ref) {
  final ip = ref.watch(remoteIpProvider.state);
  return ConnectionStatusService(radioIp: ip);
});
