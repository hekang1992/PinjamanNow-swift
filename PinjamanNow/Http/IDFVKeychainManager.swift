//
//  IDFVKeychainManager.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/3.
//


import Foundation
import Security
import UIKit
import AdSupport

class IDFVKeychainManager {
    
    private let service = Bundle.main.bundleIdentifier ?? "com.PinjamanNow.idfv"
    private let account = "device_idfv"
    
    static let shared = IDFVKeychainManager()
    
    private init() {}
    
    func getIDFA() -> String {
        let idfa = ASIdentifierManager.shared().advertisingIdentifier
        if idfa.uuidString == "00000000-0000-0000-0000-000000000000" {
            return ""
        }
        return idfa.uuidString
    }
    
    func getIDFV() -> String {
        if let storedIDFV = readIDFVFromKeychain() {
            return storedIDFV
        }
        
        guard let idfv = UIDevice.current.identifierForVendor?.uuidString else {
            return ""
        }
        
        if saveIDFVToKeychain(idfv) {
            return idfv
        }
        
        return ""
    }
    
    private func saveIDFVToKeychain(_ idfv: String) -> Bool {
        guard let idfvData = idfv.data(using: .utf8) else {
            return false
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: idfvData,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    private func readIDFVFromKeychain() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess,
              let data = dataTypeRef as? Data,
              let idfv = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return idfv
    }
    
    func updateIDFVInKeychain(_ newIDFV: String) -> Bool {
        guard let newData = newIDFV.data(using: .utf8) else {
            return false
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: newData
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        return status == errSecSuccess
    }
    
    func deleteIDFVFromKeychain() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    func regenerateIDFV() -> String? {
        _ = deleteIDFVFromKeychain()
        
        guard let idfv = UIDevice.current.identifierForVendor?.uuidString else {
            return nil
        }
        
        if saveIDFVToKeychain(idfv) {
            return idfv
        }
        
        return nil
    }
    
    func hasStoredIDFV() -> Bool {
        return readIDFVFromKeychain() != nil
    }
}
