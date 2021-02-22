import 'package:app/pages/home/home_screen.dart';
import 'package:app/services/remote_device_service.dart';
import 'package:flutter/material.dart';
import 'package:app/setup/locator.dart' as getIt;

void main() async {
  getIt.setup();
  WidgetsFlutterBinding.ensureInitialized();
  await getIt.locator<RemoteDeviceService>().init();
  await getIt.locator<RemoteDeviceService>().search();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RRadio Remote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
