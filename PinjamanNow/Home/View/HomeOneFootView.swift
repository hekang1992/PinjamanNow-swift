//
//  HomeOneFootView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/10.
//

import UIKit
import SnapKit
import Kingfisher

class HomeOneFootView: UIView {
    
    var tapBlock: ((phalarModel) -> Void)?
    
    var model: phalarModel? {
        didSet {
            guard let model = model else { return }
            
            let logoUrl = model.fensacious ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.large ?? ""
            moneyLabel.text = model.directoro ?? ""
            descLabel.text = model.legis ?? ""
            appLabel.text = model.sorc ?? ""
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pro_dl_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#010204")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.init(hexString: "#B4B4B4")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return descLabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textAlignment = .center
        moneyLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        moneyLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return moneyLabel
    }()
    
    lazy var appLabel: UILabel = {
        let appLabel = UILabel()
        appLabel.textAlignment = .center
        appLabel.textColor = UIColor.init(hexString: "#C1EBFF")
        appLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return appLabel
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        tapBtn.addTarget(self, action: #selector(tapClick), for: .touchUpInside)
        return tapBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(moneyLabel)
        bgImageView.addSubview(appLabel)
        bgImageView.addSubview(tapBtn)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 70.pix()))
            make.bottom.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(34.pix())
            make.left.equalToSuperview().offset(15)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(15)
        }
        descLabel.snp.makeConstraints { make in
            make.bottom.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(16)
        }
        moneyLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(nameLabel)
            make.height.equalTo(20)
            make.width.equalTo(107)
        }
        appLabel.snp.makeConstraints { make in
            make.centerY.equalTo(descLabel)
            make.left.right.equalTo(moneyLabel)
            make.height.equalTo(15)
        }
        tapBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeOneFootView {
    
    @objc func tapClick() {
        if let model = model {
            self.tapBlock?(model)
        }
    }
    
}
