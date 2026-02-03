//
//  OrderViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit

class OrderViewController: BaseViewController {

    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("Log in to Zoom Loan", for: .normal)
        loginBtn.addTarget(self, action: #selector(adaf), for: .touchUpInside)
        return loginBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPink
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    
    @objc func adaf() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
