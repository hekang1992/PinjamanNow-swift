//
//  LaunchViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit

class LaunchViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.image = UIImage(named: "start_page_bg")
        return bgImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        Task {
            await self.appInfo()
        }
        
    }
    
}

extension LaunchViewController {
    
    //印尼9182，印度3102
    private func appInfo() async {
        do {
            let paras = ["ordinaneous": "1", "hepat": "1", "successfulness": "1"]
            let model = try await viewModel.appInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                let americanate = model.record?.americanate ?? ""
                saveCode(code: americanate)
                changeRootVc()
            }
        } catch  {
            
        }
    }
    
    private func saveCode(code: String) {
        UserDefaults.standard.set(code, forKey: "language_code")
        UserDefaults.standard.synchronize()
    }
    
    private func changeRootVc() {
        NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil)
    }
    
}
