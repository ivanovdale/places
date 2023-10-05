package com.battery.surf.battery_plugin

import android.annotation.SuppressLint
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.EventChannel
import io.flutter.embedding.engine.plugins.FlutterPlugin
import android.content.Context
import android.content.BroadcastReceiver
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.MethodCall
import android.os.Build.VERSION_CODES
import io.flutter.plugin.common.EventChannel.EventSink
import android.content.IntentFilter
import android.content.Intent
import android.os.BatteryManager
import android.os.Build.VERSION
import android.content.ContextWrapper
import android.os.Build
import java.util.Locale
import android.os.PowerManager
import android.provider.Settings
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat
import androidx.core.content.ContextCompat.RECEIVER_NOT_EXPORTED


class BatteryPlugin : EventChannel.StreamHandler, FlutterPlugin {
    private var applicationContext: Context? = null
    private var eventChannel: EventChannel? = null
    private var batteryLevelChangeReceiver: BroadcastReceiver? = null

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        this.applicationContext = binding.applicationContext
        eventChannel = EventChannel(binding.binaryMessenger, "battery_plugin")
        eventChannel!!.setStreamHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        applicationContext = null
        eventChannel!!.setStreamHandler(null)
        eventChannel = null
    }

    @SuppressLint("WrongConstant") // Error in ContextCompat for RECEIVER_NOT_EXPORTED
    override fun onListen(arguments: Any?, events: EventSink) {
        batteryLevelChangeReceiver = createBatteryLevelChangeReceiver(events)
        applicationContext?.let {
            ContextCompat.registerReceiver(
                it, batteryLevelChangeReceiver,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED), RECEIVER_NOT_EXPORTED
            )
        }
        val level = getBatteryLevel()
        publishBatteryLevel(events, level)
    }

    override fun onCancel(arguments: Any?) {
        applicationContext!!.unregisterReceiver(batteryLevelChangeReceiver)
        batteryLevelChangeReceiver = null
    }

    private fun getBatteryLevel(): Int {
        return if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            getBatteryProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            val level = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
            val scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
            (level * 100 / scale)
        }
    }

    private fun createBatteryLevelChangeReceiver(events: EventSink): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val level = getBatteryLevel()
                publishBatteryLevel(events, level)
            }
        }
    }

    @RequiresApi(api = VERSION_CODES.LOLLIPOP)
    private fun getBatteryProperty(property: Int): Int {
        val batteryManager = applicationContext!!.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(property)
    }

    private fun publishBatteryLevel(events: EventSink, level: Int?) {
        if (level != null) {
            events.success(level)
        } else {
            events.error("UNAVAILABLE", "Battery level unavailable", null)
        }
    }
}
