//
//  Color+Ex.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit

extension UIColor {
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formattedString = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        
        if formattedString.hasPrefix("#") {
            formattedString = String(formattedString.dropFirst())
        }
        
        let length = formattedString.count
        
        var hexValue: UInt64 = 0
        guard Scanner(string: formattedString).scanHexInt64(&hexValue) else {
            return nil
        }
        
        var r, g, b, a: CGFloat
        a = alpha
        
        switch length {
        case 3:
            r = CGFloat((hexValue & 0xF00) >> 8) / 15.0
            g = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
            b = CGFloat(hexValue & 0x00F) / 15.0
            
        case 6:
            r = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            g = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
            b = CGFloat(hexValue & 0x0000FF) / 255.0
            
        case 8:
            a = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
            r = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
            g = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
            b = CGFloat(hexValue & 0x000000FF) / 255.0
            
        default:
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
