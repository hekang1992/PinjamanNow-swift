//
//  BaseViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit

class BaseViewController: UIViewController {
    
    let languageCode = LanguageManager.getLanguageCode()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
    }

}
