import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart' show OptionBuilder;

class ConnectionStatusService extends StateNotifier<bool> {
  final String radioIp;

  ConnectionStatusService({this.radioIp}) : super(false) {
    if (radioIp == null) return;
    IO.Socket socket = IO.io('http://$radioIp:8000',
        OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((_) => state = true);
    socket.onReconnect((_) => state = true);
    socket.onDisconnect((_) => state = false);
  }

  bool get active => state;
}
