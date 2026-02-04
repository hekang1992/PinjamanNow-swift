//
//  CenterViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit

class CenterViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    lazy var centerView: ProfileView = {
        let centerView = ProfileView()
        return centerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.getCenterInfo()
        }
    }
    
}

extension CenterViewController {
    
    private func getCenterInfo() async {
        do {
            let paras = ["pecunular": "1"]
            let model = try await viewModel.centerInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                
            }
        } catch {
            
        }
    }
    
}
