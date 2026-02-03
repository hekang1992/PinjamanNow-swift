//
//  AppDelegate.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupNotifications()
        setupWindow()
        setInitialViewController()
        
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension AppDelegate {
    
    enum AppNotification {
        static let changeRootViewController = Notification.Name("changeRootViewController")
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleChangeRootViewController),
            name: AppNotification.changeRootViewController,
            object: nil
        )
    }
    
    @objc private func handleChangeRootViewController() {
        let rootViewController = LoginManager.shared.isLoggedIn() ?
        MainTabBarController() :
        BaseNavigationController(rootViewController: LoginViewController())
        
        window?.rootViewController = rootViewController
    }
}

extension AppDelegate {
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    }
    
    private func setInitialViewController() {
        window?.rootViewController = LaunchViewController()
    }
}
