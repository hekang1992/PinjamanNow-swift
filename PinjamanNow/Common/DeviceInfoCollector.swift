//
//  DeviceInfoCollector.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/7.
//

import UIKit
import DeviceKit
import Foundation
import SystemConfiguration.CaptiveNetwork

final class DeviceInfoCollector {

    static func collect(completion: @escaping ([String: Any]) -> Void) {

        BatteryInfoProvider.enableMonitoring()

        var result: [String: Any] = [:]

        result["capital"] = [
            "classise": StorageInfoProvider.availableDiskSpace(),
            "orttrade": StorageInfoProvider.totalDiskSpace(),
            "prendcivilette": StorageInfoProvider.totalMemory(),
            "retern": StorageInfoProvider.availableMemory()
        ]

        result["rapacie"] = [
            "troubleaceous": BatteryInfoProvider.batteryLevel(),
            "tetandinnerive": BatteryInfoProvider.isCharging()
        ]

        let screen = DeviceInfoProvider.screenSize()
        result["probablyize"] = [
            "nu": DeviceInfoProvider.systemVersion(),
            "discussfold": "iPhone",
            "opsivity": Device.identifier,
            "standard": Device.current.description,
            "guyment": screen.height,
            "runine": screen.width,
            "numberion": String(Device.current.diagonal)
        ]

        result["fornic"] = [
            "informationth": 100,
            "yetacity": "0",
            "flatopportunityot": NetworkInfoProvider.isSimulator(),
            "rav": NetworkInfoProvider.isJailbroken(),
        ]

        let paras = DeviceSecurityHelper.fetchSecurityInfo()
        result["arrivery"] = [
            "indinumberon": NetworkInfoProvider.timeZone(),
            "ordinaneous": paras["ordinaneous"],
            "hepat": paras["hepat"],
            "frictency": "",
            "athlern": NetworkInfoProvider.idfv(),
            "statementtion": NetworkInfoProvider.language(),
            "openmost": UserDefaults.standard.object(forKey: "net_type") as? String ?? "",
            "expectry": Device.current.isPhone ? "1" : "0",
            "liter": localIPAddress(),
            "republicanally": NetworkInfoProvider.idfa(),
            "americanmost": "" // wifi BSSID，异步再补
        ]

        let wifiProvider = WifiInfoProvider()
        wifiProvider.fetchCurrentWifi { wifiList in

            let wifiArray: [[String: Any]] = wifiList.map {
                [
                    "gram": $0.bssid,
                    "laminile": $0.ssid,
                    "americanmost": $0.bssid,
                    "sy": $0.ssid,
                ]
            }

            result["discovereur"] = [
                "reporton": wifiArray
            ]

            if let first = wifiList.first {
                var arrivery = result["arrivery"] as? [String: Any] ?? [:]
                arrivery["americanmost"] = first.bssid
                result["arrivery"] = arrivery
            }

            completion(result)
        }
    }
}

extension DeviceInfoCollector {
    
   static func localIPAddress() -> String {
        var address = "0.0.0.0"
        var ifaddr: UnsafeMutablePointer<ifaddrs>?

        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                let interface = ptr!.pointee
                let addrFamily = interface.ifa_addr.pointee.sa_family

                if addrFamily == UInt8(AF_INET) {
                    let name = String(cString: interface.ifa_name)
                    if name == "en0" {
                        var addr = interface.ifa_addr.pointee
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(&addr,
                                    socklen_t(interface.ifa_addr.pointee.sa_len),
                                    &hostname,
                                    socklen_t(hostname.count),
                                    nil,
                                    socklen_t(0),
                                    NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
                ptr = interface.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return address
    }

    
}
