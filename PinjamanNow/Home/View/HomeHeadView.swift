//
//  HomeHeadView.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/3.
//

import UIKit
import SnapKit

class HomeHeadView: UIView {
    
    var serviceBlock: (() -> Void)?
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.borderColor = UIColor.white.cgColor
        logoImageView.layer.cornerRadius = 7
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return nameLabel
    }()
    
    lazy var serviceBtn: UIButton = {
        let serviceBtn = UIButton(type: .custom)
        serviceBtn.setImage(UIImage(named: "sy_kf_ic"), for: .normal)
        serviceBtn.addTarget(self, action: #selector(serviceBtnClick), for: .touchUpInside)
        return serviceBtn
    }()

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        return bgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(serviceBtn)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(34)
            make.left.equalToSuperview().offset(20)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(12)
            make.height.equalTo(20)
        }
        serviceBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
            make.right.equalToSuperview().offset(-24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeHeadView {
    
    @objc func serviceBtnClick() {
        self.serviceBlock?()
    }
}
