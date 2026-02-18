//
//  MainTabBarController.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/3.
//

import UIKit
import SnapKit
import CoreLocation

class MainTabBarController: UITabBarController {

    private let tabImages = [
        ("tab_home_ic", "tab_home_ic_01"),
        ("tab_order_ic", "tab_order_ic_01"),
        ("tab_me_ic", "tab_me_ic_01")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        setupTabBarAppearance()
    }
}

extension MainTabBarController {
    
    private func setupViewControllers() {
        
        let homeVC = HomeViewController()
        let orderVC = OrderViewController()
        let centerVC = CenterViewController()
        
        let homeNav = BaseNavigationController(rootViewController: homeVC)
        let orderNav = BaseNavigationController(rootViewController: orderVC)
        let centerNav = BaseNavigationController(rootViewController: centerVC)
        
        homeNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: tabImages[0].1)?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: tabImages[0].0)?.withRenderingMode(.alwaysOriginal)
        )
        
        orderNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: tabImages[1].1)?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: tabImages[1].0)?.withRenderingMode(.alwaysOriginal)
        )
        
        centerNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: tabImages[2].1)?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: tabImages[2].0)?.withRenderingMode(.alwaysOriginal)
        )
        
        viewControllers = [homeNav, orderNav, centerNav]
    }
    
    private func setupTabBarAppearance() {
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.items?.forEach { item in
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 300)
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
}


extension MainTabBarController: CustomTabBarDelegate {
    
    func didSelectTab(at index: Int) {
        selectedIndex = index
    }
    
    func getRootViewController(at index: Int) -> UIViewController? {
        guard index >= 0 && index < (viewControllers?.count ?? 0),
              let navController = viewControllers?[index] as? BaseNavigationController else {
            return nil
        }
        return navController.viewControllers.first
    }
}

