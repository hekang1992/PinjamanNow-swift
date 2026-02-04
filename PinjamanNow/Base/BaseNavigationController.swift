//
//  BaseNavigationController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationBar.isHidden = true
        self.navigationBar.isTranslucent = false
        if let gestureRecognizers = view.gestureRecognizers {
            for gesture in gestureRecognizers {
                if let popGesture = gesture as? UIScreenEdgePanGestureRecognizer {
                    view.removeGestureRecognizer(popGesture)
                }
            }
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}

extension BaseNavigationController: UINavigationControllerDelegate {
    
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        guard let tab = tabBarController as? MainTabBarController else { return }
        
        let isRoot = navigationController.viewControllers.first === viewController
        tab.setTabBarHidden(!isRoot)
    }
}
