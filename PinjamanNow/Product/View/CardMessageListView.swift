//
//  CardMessageListView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit

class CardMessageListView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "list_d_car_d_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#B4B4B4")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return nameLabel
    }()
    
    lazy var enterFiled: UITextField = {
        let enterFiled = UITextField()
        enterFiled.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        enterFiled.textColor = UIColor.init(hexString: "#010204")
        return enterFiled
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "rc_arwo_image")
        arrowImageView.isHidden = true
        return arrowImageView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.isHidden = true
        return clickBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(enterFiled)
        bgImageView.addSubview(arrowImageView)
        bgImageView.addSubview(clickBtn)
        bgImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 335.pix(), height: 88.pix()))
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
            make.height.equalTo(15)
        }
        enterFiled.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-30)
        }
        arrowImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 11, height: 15))
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-18)
        }
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
