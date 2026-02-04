//
//  AppCancelView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/4.
//


import UIKit
import SnapKit

class AppCancelView: UIView {
    
    var sureBlock: (() -> Void)?
    
    var cancelBlock: (() -> Void)?
    
    let languageCode = LanguageManager.current
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "dc_ec_image")
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var leftBtn: UIButton = {
        let leftBtn = UIButton(type: .custom)
        leftBtn.setTitle(languageCode == .indonesian ? "Mengonfirmasi" : "Confirm", for: .normal)
        leftBtn.setTitleColor(UIColor.init(hexString: "#0956FB"), for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        leftBtn.layer.borderWidth = 1
        leftBtn.layer.borderColor = UIColor.init(hexString: "#0956FB")?.cgColor
        leftBtn.layer.cornerRadius = 22
        leftBtn.layer.masksToBounds = true
        leftBtn.addTarget(self, action: #selector(sureClick), for: .touchUpInside)
        return leftBtn
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitle(languageCode == .indonesian ? "Membatalkan" : "Cancel", for: .normal)
        rightBtn.setTitleColor(.white, for: .normal)
        rightBtn.backgroundColor = UIColor.init(hexString: "#0956FB")
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        rightBtn.layer.borderWidth = 1
        rightBtn.layer.borderColor = UIColor.init(hexString: "#0956FB")?.cgColor
        rightBtn.layer.cornerRadius = 22
        rightBtn.layer.masksToBounds = true
        rightBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        return rightBtn
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setImage(UIImage(named: "login_tc_xz_image"), for: .normal)
        sureBtn.setImage(UIImage(named: "login_tc_sel_image"), for: .selected)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        return sureBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = "I have read and agree to the above"
        nameLabel.textColor = UIColor.init(hexString: "#0956FB")
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(leftBtn)
        bgImageView.addSubview(rightBtn)
        bgImageView.addSubview(sureBtn)
        bgImageView.addSubview(nameLabel)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 288.pix(), height: 340.pix()))
        }
        
        leftBtn.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview().inset(15.pix())
            if languageCode == .indonesian {
                make.size.equalTo(CGSize(width: 112.pix(), height: 46.pix()))
            }else {
                make.size.equalTo(CGSize(width: 130.pix(), height: 44.pix()))
            }
        }
        
        rightBtn.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(15.pix())
            make.size.equalTo(CGSize(width: 130.pix(), height: 44.pix()))
        }
        
        sureBtn.snp.makeConstraints { make in
            make.width.height.equalTo(14.pix())
            make.left.equalToSuperview().offset(28.pix())
            make.bottom.equalTo(leftBtn.snp.top).offset(-30.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sureBtn)
            make.left.equalTo(sureBtn.snp.right).offset(8)
            make.height.equalTo(14)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AppCancelView {
    
    @objc private func sureClick() {
        self.sureBlock?()
    }
    
    @objc private func cancelClick() {
        self.cancelBlock?()
    }
    
    @objc private func sureBtnClick() {
        sureBtn.isSelected.toggle()
    }
    
}
