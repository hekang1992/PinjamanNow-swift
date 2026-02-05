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
        
        view.backgroundColor = UIColor(hexString: "#F3F3F3")
    }
    
}

extension BaseViewController {
    
    func goH5WebVcWith(to pageUrl: String) {
        let h5WebVc = H5ViewController()
        h5WebVc.pageUrl = pageUrl
        self.navigationController?.pushViewController(h5WebVc, animated: true)
    }
    
    func toProductVc() {
        guard let nav = navigationController else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
        
        if let productVC = nav.viewControllers.compactMap({ $0 as? ProductViewController }).first {
            nav.popToViewController(productVC, animated: true)
        } else {
            nav.popToRootViewController(animated: true)
        }
    }
    
}

extension BaseViewController {
    
    func productMessageInfo(with productID: String, orderID: String, viewModel: AppViewModel) async {
        do {
            let paras = ["institutionit": productID]
            let model = try await viewModel.productDetailInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                
            }
        } catch {
            
        }
    }
    
    func toNextVc(typeModel: astyModel, cardModel: populModel) {
        
    }
    
}
