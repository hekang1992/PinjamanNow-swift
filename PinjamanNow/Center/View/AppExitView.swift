//
//  AppExitView.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/4.
//

import UIKit
import SnapKit

class AppExitView: UIView {
    
    var sureBlock: (() -> Void)?
    
    var cancelBlock: (() -> Void)?
    
    let languageCode = LanguageManager.current
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == .indonesian ? UIImage(named: "exit_edc_image") : UIImage(named: "exit_ec_image")
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(leftBtn)
        bgImageView.addSubview(rightBtn)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 289.pix(), height: 285.pix()))
        }
        
        leftBtn.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview().inset(15.pix())
            if languageCode == .indonesian {
                make.size.equalTo(CGSize(width: 112.pix(), height: 44.pix()))
            }else {
                make.size.equalTo(CGSize(width: 104.pix(), height: 44.pix()))
            }
        }
        
        rightBtn.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(15.pix())
            make.size.equalTo(CGSize(width: 130.pix(), height: 44.pix()))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AppExitView {
    
    @objc private func sureClick() {
        self.sureBlock?()
    }
    
    @objc private func cancelClick() {
        self.cancelBlock?()
    }
    
}
