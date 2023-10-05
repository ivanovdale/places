import 'package:battery_plugin/battery_plugin_method_channel.dart';

class BatteryPlugin {
  factory BatteryPlugin() {
    _singleton ??= BatteryPlugin._();
    return _singleton!;
  }

  BatteryPlugin._();

  static BatteryPlugin? _singleton;

  static MethodChannelBatteryPlugin get _platform {
    return MethodChannelBatteryPlugin.instance;
  }

  Stream<int> get onBatteryLevelChanged => _platform.onBatteryStateChanged;
}
