import 'package:app/services/remote_device_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final remoteIpProvider =
    StateNotifierProvider<RemoteDeviceService>((_) => RemoteDeviceService());

final remoteConnectionProvider = FutureProvider<bool>((ref) async {
  await ref.watch(remoteIpProvider).init();
  return await ref.watch(remoteIpProvider).search();
});
