//
//  CompleteViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit

class CompleteViewController: BaseViewController {
    
    var orderID: String = ""
    
    var productID: String = ""
    
    var pageTitle: String = ""
    
    private let viewModel = AppViewModel()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setTitleColor(.white, for: .normal)
        sureBtn.setTitle(languageCode == .indonesian ? "OKE" : "OK", for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        sureBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        return sureBtn
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == .indonesian ?
        UIImage(named: "en_c_w_image") :
        UIImage(named: "id_c_w_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = languageCode == .indonesian ?
        UIImage(named: "fa_desc_id_imci") :
        UIImage(named: "fa_desc_a_imci")
        descImageView.contentMode = .scaleAspectFit
        return descImageView
    }()
    
    lazy var footImageView: UIImageView = {
        let footImageView = UIImageView()
        footImageView.image = UIImage(named: "fa_dcm_a_imci")
        footImageView.contentMode = .scaleAspectFit
        return footImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#0956FB")
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(488.pix())
        }
        
        view.addSubview(appHeadView)
        appHeadView.nameLabel.text = pageTitle
        appHeadView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        appHeadView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toProductVc()
        }
        
        view.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 315.pix(), height: 55.pix()))
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(appHeadView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(sureBtn.snp.top).offset(-10.pix())
        }
        
        scrollView.addSubview(bgImageView)
        scrollView.addSubview(descImageView)
        scrollView.addSubview(footImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 289.pix(), height: 194.pix()))
        }
        descImageView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 60.pix()))
        }
        footImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descImageView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 335.pix(), height: 309.pix()))
            make.bottom.equalToSuperview().offset(-20.pix())
        }
    }
    
}

extension CompleteViewController {
    
    @objc func sureBtnClick() {
        Task {
            await self.productMessageInfo(with: productID,
                                          orderID: orderID,
                                          viewModel: viewModel)
        }
    }
}
