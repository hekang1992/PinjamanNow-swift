//
//  Para.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import Foundation
import DeviceKit

class CommonParaManager {
    
    static var dictionary: [String: Any] {
        let idfv = IDFVKeychainManager.shared.getIDFV() ?? ""
        
        return [
            "studo": "ios",
            "die": "die",
            "seboie": Device.current.description,
            "propertyward": idfv,
            "gradsome": Device.current.systemVersion ?? "",
            "recognizeth": "pinjaman_now",
            "salinee": "",
            "ovile": idfv,
            "americanate": ""
        ]
    }
    
    static func toJson() -> [String: String] {
        return dictionary.mapValues { "\($0)" }
    }
    
}
