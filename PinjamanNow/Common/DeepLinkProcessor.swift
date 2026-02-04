//
//  DeepLinkProcessor.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/4.
//

import UIKit

final class DeepLinkProcessor {
    
    private static let validScheme = "iridular"
    private static let validHost = "crepitan.patieer.oilitious"
    
    static func handleString(_ link: String, from viewController: UIViewController) {
        guard let url = URL(string: link) else {
            return
        }
        handleURL(url, from: viewController)
    }
    
    static func handleURL(_ url: URL, from viewController: UIViewController) {
        guard isValidURL(url) else {
            return
        }
        
        let path = url.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        let params = queryItems?.reduce(into: [String: String]()) { $0[$1.name] = $1.value } ?? [:]
        
        navigateToPath(path, parameters: params, from: viewController)
    }
    
    private static func isValidURL(_ url: URL) -> Bool {
        return url.scheme?.lowercased() == validScheme &&
        url.host?.lowercased() == validHost
    }
    
    private static func navigateToPath(_ path: String, parameters: [String: String], from viewController: UIViewController) {
        
        guard let nav = viewController.navigationController else {
            return
        }
        
        switch path {
        case "plurimaneity":
            NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil)
            
        case "gonotic":
            let settingVc = SettingsViewController()
            nav.pushViewController(settingVc, animated: true)
            
        case "coupleette":
            LoginManager.shared.clearAll()
            Task {
                try? await Task.sleep(nanoseconds: 250_000_000)
                NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil)
            }
        case "fugitdom":
            break
            
        case "arborion":
            break
            
        default:
            break
        }
    }
}
