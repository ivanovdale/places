import 'package:flutter/services.dart';

class MethodChannelBatteryPlugin {
  final _eventChannel = const EventChannel('battery_plugin');
  Stream<int>? _onBatteryLevelChanged;

  static MethodChannelBatteryPlugin instance = MethodChannelBatteryPlugin();

  Stream<int> get onBatteryStateChanged {
    _onBatteryLevelChanged ??= _eventChannel
        .receiveBroadcastStream()
        .map((dynamic value) => value ?? 0);
    return _onBatteryLevelChanged!;
  }
}
