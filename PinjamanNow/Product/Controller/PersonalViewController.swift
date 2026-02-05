//
//  PersonalViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit

class PersonalViewController: BaseViewController {
    
    var orderID: String = ""
    
    var productID: String = ""
    
    var pageTitle: String = ""
    
    private let viewModel = AppViewModel()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setTitleColor(.white, for: .normal)
        sureBtn.setTitle(languageCode == .indonesian ? "Berikutnya" : "Next", for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        sureBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        return sureBtn
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "basic_info_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 14
        bgView.layer.masksToBounds = true
        bgView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#0956FB")
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(295.pix())
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
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appHeadView.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 345.pix(), height: 240.pix()))
        }
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom)
            make.left.right.equalToSuperview().inset(15.pix())
            make.bottom.equalTo(sureBtn.snp.top).offset(-10.pix())
        }
    }
    
}

extension PersonalViewController {
    
    @objc func sureBtnClick() {
        
    }
}

