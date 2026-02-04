//
//  AppEmptyView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/4.
//

import UIKit
import SnapKit

class AppEmptyView: UIView {
    
    var addAction: (() -> Void)?
    
    let languageCode = LanguageManager.current

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == .indonesian ?
            UIImage(named: "li_emp_id_image") :
            UIImage(named: "li_emp_en_image")
        
        bgImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        bgImageView.addGestureRecognizer(tapGesture)
        
        return bgImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            if languageCode == .indonesian {
                make.size.equalTo(CGSize(width: 206, height: 219))
            }else {
                make.size.equalTo(CGSize(width: 175, height: 219))
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AppEmptyView {
    
    @objc private func handleImageTap() {
        self.addAction?()
    }
    
}
