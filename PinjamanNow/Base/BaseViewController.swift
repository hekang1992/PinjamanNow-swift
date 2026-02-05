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
                self.toNextVc(typeModel: model.record?.applyorium ?? astyModel(),
                              cardModel: model.record?.popul ?? populModel())
            }
        } catch {
            
        }
    }
    
    func toNextVc(typeModel: astyModel, cardModel: populModel) {
        let type = typeModel.tv ?? ""
        
        switch type {
        case "tensia":
            break
            
        case "recentorium":
            let personalVc = PersonalViewController()
            personalVc.pageTitle = typeModel.actionsome ?? ""
            personalVc.orderID = cardModel.canproof ?? ""
            personalVc.productID = cardModel.personal ?? ""
            self.navigationController?.pushViewController(personalVc, animated: true)
            
        case "womanture":
            let flossVc = FlossViewController()
            flossVc.pageTitle = typeModel.actionsome ?? ""
            flossVc.orderID = cardModel.canproof ?? ""
            flossVc.productID = cardModel.personal ?? ""
            self.navigationController?.pushViewController(flossVc, animated: true)
            
        case "oplaceous":
            let walletVc = WalletViewController()
            walletVc.pageTitle = typeModel.actionsome ?? ""
            walletVc.orderID = cardModel.canproof ?? ""
            walletVc.productID = cardModel.personal ?? ""
            self.navigationController?.pushViewController(walletVc, animated: true)
            
        default:
            break
        }
    }
    
}
