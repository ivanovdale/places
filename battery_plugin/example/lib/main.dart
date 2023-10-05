import 'package:battery_plugin/battery_plugin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Battery Plugin example app'),
        ),
        body: const Center(
          child: _BatteryLevelInfo(),
        ),
      ),
    );
  }
}

class _BatteryLevelInfo extends StatefulWidget {
  const _BatteryLevelInfo();

  @override
  State<_BatteryLevelInfo> createState() => _BatteryLevelInfoState();
}

class _BatteryLevelInfoState extends State<_BatteryLevelInfo> {
  int _currentBatteryLevel = 0;
  late final Stream<int>? _batteryLevelStream;

  void _attachBatteryLevelListener() {
    _batteryLevelStream?.listen(
      (batteryLevel) {
        if (batteryLevel < _currentBatteryLevel) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Battery level was decreased'),
            ),
          );
        }

        _currentBatteryLevel = batteryLevel;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _batteryLevelStream = BatteryPlugin().onBatteryLevelChanged;
    _attachBatteryLevelListener();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _batteryLevelStream,
      builder: (context, snapshot) {
        return Text('Battery level is: $_currentBatteryLevel');
      },
    );
  }
}
