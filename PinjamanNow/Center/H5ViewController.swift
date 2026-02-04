//
//  H5ViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/4.
//

import UIKit
import SnapKit

class H5ViewController: BaseViewController {
    
    var pageUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(appHeadView)
        appHeadView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        appHeadView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

}
