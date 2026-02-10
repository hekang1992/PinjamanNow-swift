//
//  AppDelegate.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/3.
//

import UIKit
import IQKeyboardManagerSwift

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
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleChangeRootViewController(_:)),
            name: AppNotification.changeRootViewController,
            object: nil
        )
    }
    
    @objc private func handleChangeRootViewController(_ noti: Notification) {
        let tabBar = MainTabBarController()
        let userInfo = noti.userInfo as? [String: String]
        let index = Int(userInfo?["tabBar"] ?? "0") ?? 0
        let type = userInfo?["type"] ?? ""
        
        tabBar.didSelectTab(at: index)
        
        if let targetVC = tabBar.getRootViewController(at: index) {
            if index == 1, let orderVC = targetVC as? OrderViewController {
                switch type {
                case "4":
                    orderVC.orderType = .all
                    orderVC.orderView.clickblock?(.all)
                    orderVC.orderView.updateSelectedButton(orderVC.orderView.oneBtn, animated: false)
                    
                case "7":
                    orderVC.orderType = .inProgress
                    orderVC.orderView.clickblock?(.inProgress)
                    orderVC.orderView.updateSelectedButton(orderVC.orderView.twoBtn, animated: false)
                    
                case "6":
                    orderVC.orderType = .repayment
                    orderVC.orderView.clickblock?(.repayment)
                    orderVC.orderView.updateSelectedButton(orderVC.orderView.threeBtn, animated: false)
                    
                case "5":
                    orderVC.orderType = .finished
                    orderVC.orderView.clickblock?(.finished)
                    orderVC.orderView.updateSelectedButton(orderVC.orderView.fourBtn, animated: false)
                    
                default:
                    break
                }
                
            }
        }
        
        let rootViewController = LoginManager.shared.isLoggedIn() ?
        tabBar :
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
