//
//  LoginManager.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/3.
//


import Foundation

class LoginManager {
    static let shared = LoginManager()
    
    private let phoneKey = "user_phone"
    private let tokenKey = "user_token"
    private let isLoggedInKey = "is_logged_in"
    
    private init() {}
    
    func saveLoginInfo(phone: String, token: String) {
        UserDefaults.standard.set(phone, forKey: phoneKey)
        UserDefaults.standard.set(token, forKey: tokenKey)
        UserDefaults.standard.set(true, forKey: isLoggedInKey)
        UserDefaults.standard.synchronize()
    }
    
    func getPhone() -> String {
        return UserDefaults.standard.string(forKey: phoneKey) ?? ""
    }
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func isLoggedIn() -> Bool {
        if let token = getToken(), !token.isEmpty {
            return UserDefaults.standard.bool(forKey: isLoggedInKey)
        }
        return false
    }
    
    func clearAll() {
        let keys = [phoneKey, tokenKey, isLoggedInKey]
        keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.synchronize()
        
    }
    
    
}
