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
 
    private func appInfo() async {
        do {
            let paras = ["": ""]
            let model = try await viewModel.appInfo(with: paras)
            
        } catch  {
            
        }
    }
    
}
