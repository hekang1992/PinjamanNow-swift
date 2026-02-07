//
//  DeviceInfoProvider.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/7.
//

import UIKit

final class DeviceInfoProvider {

    static func systemVersion() -> String {
        UIDevice.current.systemVersion
    }

    static func deviceModel() -> String {
        UIDevice.current.model
    }

    static func screenSize() -> (width: Int, height: Int) {
        let size = UIScreen.main.bounds.size
        return (Int(size.width), Int(size.height))
    }
}
