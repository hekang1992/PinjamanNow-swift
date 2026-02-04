//
//  MainTabBarController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit

class MainTabBarController: UITabBarController {

    private let customTabBar = CustomTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupCustomTabBar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.isHidden = true
    }
}

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
}

extension MainTabBarController {

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

extension MainTabBarController: CustomTabBarDelegate {

    func didSelectTab(at index: Int) {
        selectedIndex = index
    }
}
