//
//  Para.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/3.
//

import Foundation
import DeviceKit

class CommonParaManager {
    
    static var dictionary: [String: Any] {
        let idfv = IDFVKeychainManager.shared.getIDFV() ?? ""
        
        return [
            "studo": "ios",
            "die": "1.0.0",
            "seboie": Device.current.description,
            "propertyward": idfv,
            "gradsome": Device.current.systemVersion ?? "",
            "recognizeth": "pinjaman_now",
            "salinee": LoginManager.shared.getToken() ?? "",
            "ovile": idfv,
            "americanate": UserDefaults.standard.object(forKey: "language_code") ?? ""
        ]
    }
    
    static func toJson() -> [String: String] {
        return dictionary.mapValues { "\($0)" }
    }
    
}
