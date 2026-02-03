//
//  MainViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let customTabBar = CustomTabBar()
    private var currentViewController: UIViewController?
    
    private let homeVC = HomeViewController()
    private let discoverVC = OrderViewController()
    private let profileVC = CenterViewController()
    
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
            make.width.equalTo(335)
            make.height.equalTo(62)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        customTabBar.delegate = self
    }
    
    private func setupViewControllers() {
        addChild(homeVC)
        addChild(discoverVC)
        addChild(profileVC)
        
        view.insertSubview(homeVC.view, at: 0)
        view.insertSubview(discoverVC.view, at: 0)
        view.insertSubview(profileVC.view, at: 0)
        
        homeVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        discoverVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func selectTab(at index: Int) {
        homeVC.view.isHidden = true
        discoverVC.view.isHidden = true
        profileVC.view.isHidden = true
        
        switch index {
        case 0:
            homeVC.view.isHidden = false
            currentViewController = homeVC
        case 1:
            discoverVC.view.isHidden = false
            currentViewController = discoverVC
        case 2:
            profileVC.view.isHidden = false
            currentViewController = profileVC
        default:
            break
        }
        
        customTabBar.setSelectedTab(at: index)
    }
}

extension MainViewController: CustomTabBarDelegate {
    func didSelectTab(at index: Int) {
        selectTab(at: index)
        
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve) {
            self.selectTab(at: index)
        }
    }
}
