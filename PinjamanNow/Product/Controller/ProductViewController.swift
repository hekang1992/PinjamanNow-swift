//
//  ProductViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit
import MJRefresh

class ProductViewController: BaseViewController {
    
    var productID: String = ""
    
    private let viewModel = AppViewModel()
    
    private var model: BaseModel?
    
    lazy var productView: ProductView = {
        let productView = ProductView()
        return productView
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setTitleColor(.white, for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        sureBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        return sureBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sureBtn)
        view.addSubview(productView)
        
        sureBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 315.pix(), height: 55.pix()))
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        productView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(sureBtn.snp.top).offset(-10.pix())
        }
        
        productView.appHeadView.backBlock = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        productView.cellBlock = { [weak self] model in
            guard let self = self else { return }
            let meria = model.meria ?? 0
            if meria == 1 {
                self.toNextVc(typeModel: model,
                              cardModel: self.model?.record?.popul ?? populModel(), viewModel: viewModel)
            }else {
                self.sureBtnClick()
            }
        }
        
        productView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.detailInfo()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.detailInfo()
        }
    }
    
}

extension ProductViewController {
    
    @objc func sureBtnClick() {
        let type = self.model?.record?.applyorium?.tv ?? ""
        if type == "tensia" {
            Task {
                await self.getCardInfo(with: self.model?.record?.applyorium ?? astyModel())
            }
        }else {
            toNextVc(typeModel: self.model?.record?.applyorium ?? astyModel(),
                     cardModel: self.model?.record?.popul ?? populModel(),
                     viewModel: viewModel)
        }
    }
    
//    private func stepInfo(with typeModel: astyModel, cardModel: populModel?) {
//        let type = typeModel.tv ?? ""
//        switch type {
//        case "tensia":
//            Task {
//                await self.getCardInfo(with: typeModel)
//            }
//            
//        case "recentorium":
//            let personalVc = PersonalViewController()
//            personalVc.productID = productID
//            personalVc.orderID = cardModel?.canproof ?? ""
//            personalVc.pageTitle = typeModel.actionsome ?? ""
//            self.navigationController?.pushViewController(personalVc, animated: true)
//            
//        case "womanture":
//            break
//            
//        case "oplaceous":
//            break
//            
//        default:
//            break
//        }
//    }
    
    private func detailInfo() async {
        do {
            let paras = ["institutionit": productID]
            let model = try await viewModel.productDetailInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                self.model = model
                self.productView.model = model.record
                self.productView.tableView.reloadData()
                self.configTitle(with: model)
            }
            await MainActor.run {
                self.productView.tableView.mj_header?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                self.productView.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func configTitle(with model: BaseModel) {
        self.sureBtn.setTitle(model.record?.popul?.sorc ?? "", for: .normal)
    }
    
}

extension ProductViewController {
    
    private func getCardInfo(with listModel: astyModel?) async {
        let paras = ["institutionit": productID]
        do {
            let model = try await viewModel.cardInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                let cardImageUrl = model.record?.sorb?.graphen ?? ""
                let faceImageUrl = model.record?.computer?.graphen ?? ""
                if cardImageUrl.isEmpty {
                    goCardPage(with: listModel)
                    return
                }
                
                if faceImageUrl.isEmpty {
                    goFacePage(with: listModel)
                    return
                }
                
                goCompletePage(with: listModel)
            }
        } catch {
            
        }
    }
    
    private func goCardPage(with listModel: astyModel?) {
        let cardVc = CardViewController()
        cardVc.productID = productID
        cardVc.orderID = self.model?.record?.popul?.canproof ?? ""
        cardVc.pageTitle = listModel?.actionsome ?? ""
        self.navigationController?.pushViewController(cardVc, animated: true)
    }
    
    private func goFacePage(with listModel: astyModel?) {
        let faceVc = FacialViewController()
        faceVc.productID = productID
        faceVc.orderID = self.model?.record?.popul?.canproof ?? ""
        faceVc.pageTitle = listModel?.actionsome ?? ""
        self.navigationController?.pushViewController(faceVc, animated: true)
    }
    
    private func goCompletePage(with listModel: astyModel?) {
        let completeVc = CompleteViewController()
        completeVc.productID = productID
        completeVc.pageTitle = listModel?.actionsome ?? ""
        self.navigationController?.pushViewController(completeVc, animated: true)
    }
    
}
