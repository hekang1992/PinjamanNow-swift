//
//  MainTabBarController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit

class MainTabBarController: UIViewController {
    
    private let customTabBar = CustomTabBar()
    
    private var tabBarBottomConstraint: Constraint?
    
    private lazy var homeNav = BaseNavigationController(rootViewController: HomeViewController())
    private lazy var orderNav = BaseNavigationController(rootViewController: OrderViewController())
    private lazy var centerNav = BaseNavigationController(rootViewController: CenterViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
        setupViewControllers()
        selectTab(at: 0)
    }
    
    private func setupCustomTabBar() {
        view.addSubview(customTabBar)
        
        customTabBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(335.pix())
            make.height.equalTo(62.pix())
            self.tabBarBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
        }
        
        customTabBar.delegate = self
    }
    
    private func setupViewControllers() {
        let navs = [homeNav, orderNav, centerNav]
        navs.forEach { nav in
            nav.delegate = self
            addChild(nav)
            view.insertSubview(nav.view, at: 0)
            nav.view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    private func selectTab(at index: Int) {
        let navs = [homeNav, orderNav, centerNav]
        for (i, nav) in navs.enumerated() {
            nav.view.isHidden = (i != index)
        }
        customTabBar.setSelectedTab(at: index)
    }
    
    func setTabBarHidden(_ hidden: Bool, animated: Bool = true) {
        let offset = hidden ? 150 : 0
        
        if animated {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
                self.tabBarBottomConstraint?.update(offset: offset)
                self.customTabBar.alpha = hidden ? 0 : 1
                self.view.layoutIfNeeded()
            }
        } else {
            self.tabBarBottomConstraint?.update(offset: offset)
            self.customTabBar.alpha = hidden ? 0 : 1
        }
    }
}

extension MainTabBarController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let isRoot = navigationController.viewControllers.count == 1
        setTabBarHidden(!isRoot, animated: animated)
    }
}

extension MainTabBarController: CustomTabBarDelegate {
    func didSelectTab(at index: Int) {
        selectTab(at: index)
    }
}
