//
//  AppLeoView.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/10.
//

import UIKit
import SnapKit

class AppLeoView: UIView {
    
    var sureBlock: (() -> Void)?
    
    var cancelBlock: (() -> Void)?
    
    let languageCode = LanguageManager.current
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == .indonesian ? UIImage(named: "l_id_ec_image") : UIImage(named: "l_i_ec_image")
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var leftBtn: UIButton = {
        let leftBtn = UIButton(type: .custom)
        leftBtn.addTarget(self, action: #selector(sureClick), for: .touchUpInside)
        return leftBtn
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        rightBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        return rightBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(leftBtn)
        bgImageView.addSubview(rightBtn)
        bgImageView.addSubview(cancelBtn)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 289.pix(), height: 356.pix()))
        }
        
        leftBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 110.pix(), height: 44.pix()))
            make.bottom.equalToSuperview().offset(-48.pix())
            make.left.equalToSuperview().inset(15.pix())
        }
        
        rightBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-48.pix())
            make.right.equalToSuperview().inset(-15.pix())
            make.size.equalTo(CGSize(width: 130.pix(), height: 44.pix()))
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(20.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AppLeoView {
    
    @objc private func sureClick() {
        self.sureBlock?()
    }
    
    @objc private func cancelClick() {
        self.cancelBlock?()
    }
    
}
