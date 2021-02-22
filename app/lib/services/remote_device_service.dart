import 'dart:io';

import 'package:local_ip/local_ip.dart';
import 'package:udp/udp.dart';

class RemoteDeviceService {
  UDP _receiver, _sender;
  String _remoteDeviceIp;
  String get remoteDeviceIp => _remoteDeviceIp;

  Future<void> init() async {
    // creates a UDP instance and binds it to the first available network
    // interface on port 8083.
    _sender = await UDP.bind(Endpoint.any(port: Port(8083)));
    // creates a new UDP instance and binds it to the local address and the port
    // 8085.
    final _localIp = await LocalIp.ip;
    _receiver = await UDP
        .bind(Endpoint.unicast(InternetAddress(_localIp), port: Port(8085)));
  }

  bool active() {
    return !_receiver.closed && !_sender.closed;
  }

  Future<void> search() async {
    // send a simple string to a broadcast endpoint on port 8082.
    await _sender.send("remote_controller_client".codeUnits,
        Endpoint.broadcast(port: Port(8082)));

    // receiving\listening
    _receiver.listen((datagram) {
      var str = String.fromCharCodes(datagram.data);
      print(str);
      print(datagram.address);
      if (str == "remote_radio") _remoteDeviceIp = datagram.address.address;
      _receiver.close();
    });

    // close the UDP instances and their sockets.
    _sender.close();
  }
}
