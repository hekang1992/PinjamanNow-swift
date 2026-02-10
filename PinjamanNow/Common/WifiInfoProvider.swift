//
//  WifiInfoProvider.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/7.
//

import Foundation
import NetworkExtension

final class WifiInfoProvider {

    struct WifiInfo {
        let ssid: String
        let bssid: String
    }

    func fetchCurrentWifi(completion: @escaping ([WifiInfo]) -> Void) {

        NEHotspotNetwork.fetchCurrent { network in
            guard let network = network else {
                completion([])
                return
            }

            let info = WifiInfo(
                ssid: network.ssid,
                bssid: network.bssid
            )

            completion([info])
        }
    }
}

