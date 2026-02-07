//
//  NetworkInfoProvider.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/7.
//

import UIKit
import AdSupport
import CoreTelephony

final class NetworkInfoProvider {

    static func isSimulator() -> Int {
        #if targetEnvironment(simulator)
        return 1
        #else
        return 0
        #endif
    }

    static func isJailbroken() -> Int {
        let paths = ["/Applications/Cydia.app",
                     "/bin/bash",
                     "/usr/sbin/sshd"]
        return paths.contains { FileManager.default.fileExists(atPath: $0) } ? 1 : 0
    }

    static func idfa() -> String {
        IDFVKeychainManager.shared.getIDFA()
    }

    static func idfv() -> String {
        IDFVKeychainManager.shared.getIDFV()
    }

    static func language() -> String {
        Locale.current.identifier
    }

    static func timeZone() -> String {
        TimeZone.current.abbreviation() ?? ""
    }
}
