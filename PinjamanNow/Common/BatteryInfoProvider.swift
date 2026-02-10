//
//  BatteryInfoProvider.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/7.
//

import UIKit

final class BatteryInfoProvider {

    static func enableMonitoring() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }

    static func batteryLevel() -> Int {
        let level = UIDevice.current.batteryLevel
        return level < 0 ? -1 : Int(level * 100)
    }

    static func isCharging() -> Int {
        let state = UIDevice.current.batteryState
        return (state == .charging || state == .full) ? 1 : 0
    }
}
