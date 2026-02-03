//
//  DeviceSecurityHelper.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import Foundation
import SystemConfiguration

struct DeviceSecurityHelper {
    
    static func fetchSecurityInfo() -> [String: String] {
        return [
            "ordinaneous": isProxyActive() ? "1" : "0",
            "hepat": isVPNConnected() ? "1" : "0",
            "successfulness": getSystemLanguage()
        ]
    }
    
    private static func isProxyActive() -> Bool {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [AnyHashable: Any],
              let proxies = CFNetworkCopyProxiesForURL(URL(string: "https://www.apple.com")! as CFURL, proxySettings as CFDictionary).takeRetainedValue() as? [[AnyHashable: Any]] else {
            return false
        }
        
        for proxy in proxies {
            if let type = proxy[kCFProxyTypeKey] as? String, type != kCFProxyTypeNone as String {
                return true
            }
        }
        return false
    }
    
    private static func isVPNConnected() -> Bool {
        let cfDict = CFNetworkCopySystemProxySettings()
        let nsDict = cfDict!.takeRetainedValue() as NSDictionary
        let keys = nsDict["__SCOPED__"] as? NSDictionary
        
        for key: String in keys?.allKeys as? [String] ?? [] {
            if key.contains("tap") || key.contains("tun") ||
                key.contains("ppp") || key.contains("ipsec") ||
                key.contains("utun") {
                return true
            }
        }
        return false
    }
    
    private static func getSystemLanguage() -> String {
        return Locale.preferredLanguages.first ?? "en_US"
    }
}
