import 'package:app/pages/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/setup/locator.dart' as getIt;
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  getIt.setup();
  WidgetsFlutterBinding.ensureInitialized();
  // final remoteDeviceSvc = getIt.locator<RemoteDeviceService>();
  // await remoteDeviceSvc.init();
  // await remoteDeviceSvc.search();
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RMusicPlayer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
