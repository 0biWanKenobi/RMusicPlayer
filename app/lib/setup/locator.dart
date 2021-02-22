import 'package:app/services/radio_control_service.dart';
import 'package:app/services/remote_device_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton(() => RadioControlService());
  locator.registerLazySingleton(() => RemoteDeviceService());
}
