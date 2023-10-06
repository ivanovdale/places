import Flutter

public class BatteryPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {

    var eventSink: FlutterEventSink?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = BatteryPlugin()
        let batteryLevelChannel = FlutterEventChannel(name: "battery_plugin", binaryMessenger: registrar.messenger())
        batteryLevelChannel.setStreamHandler(instance)
    }

    private func getBatteryLevel() -> Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if UIDevice.current.batteryState == .unknown {
            return -1
        } else {
            return Int(UIDevice.current.batteryLevel * 100)
        }
    }

    public func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        UIDevice.current.isBatteryMonitoringEnabled = true
        sendBatteryLevelEvent()

        NotificationCenter.default.addObserver(self, selector: #selector(onBatteryLevelDidChange(_:)), name: UIDevice.batteryLevelDidChangeNotification, object: nil)

        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        NotificationCenter.default.removeObserver(self)
        eventSink = nil
        return nil
    }

    @objc private func onBatteryLevelDidChange(_ notification: Notification) {
        sendBatteryLevelEvent()
    }

    private func sendBatteryLevelEvent() {
        guard let eventSink = eventSink else {
            return
        }

        let state = getBatteryLevel()
        eventSink(state)
    }
}
