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
    
    let customTabBar = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupCustomTabBar()
        tabBar.removeFromSuperview()
    }
    
}

// MARK: - Setup
extension MainTabBarController {
    
    private func setupViewControllers() {
        let homeVC = HomeViewController()
        let orderVC = OrderViewController()
        let centerVC = CenterViewController()
        
        viewControllers = [
            BaseNavigationController(rootViewController: homeVC),
            BaseNavigationController(rootViewController: orderVC),
            BaseNavigationController(rootViewController: centerVC)
        ]
    }
    
    private func setupCustomTabBar() {
        customTabBar.delegate = self
        view.addSubview(customTabBar)
        
        customTabBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(335.pix())
            make.height.equalTo(62.pix())
        }
    }
}

// MARK: - Tab Switch
extension MainTabBarController: CustomTabBarDelegate {
    
    func didSelectTab(at index: Int) {
        selectedIndex = index
    }
}

// MARK: - Show / Hide CustomTabBar
extension MainTabBarController {
    
    override func setTabBarHidden(_ hidden: Bool, animated: Bool = true) {
        let offset = customTabBar.frame.height + view.safeAreaInsets.bottom
        let transform = hidden
        ? CGAffineTransform(translationX: 0, y: offset)
        : .identity
        
        guard customTabBar.transform != transform else { return }
        
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.customTabBar.transform = transform
            }
        } else {
            customTabBar.transform = transform
        }
    }
    
    override var selectedIndex: Int {
        didSet {
            customTabBar.setSelectedTab(at: selectedIndex)
        }
    }
}
