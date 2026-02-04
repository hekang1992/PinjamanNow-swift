//
//  BaseViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit

class BaseViewController: UIViewController {
    
    let languageCode = LanguageManager.current
    
    lazy var appHeadView: H5HeadView = {
        let appHeadView = H5HeadView()
        return appHeadView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
    }
    
}

extension BaseViewController {
    
    func goH5WebVcWith(to pageUrl: String) {
        let h5WebVc = H5ViewController()
        h5WebVc.pageUrl = pageUrl
        self.navigationController?.pushViewController(h5WebVc, animated: true)
    }
    
}
