//
//  H5HeadView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/4.
//

import UIKit
import SnapKit

class H5HeadView: UIView {
    
    var backBlock: (() -> Void)?

    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "back_image"), for: .normal)
        backBtn.setImage(UIImage(named: "back_image"), for: .selected)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        return backBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return nameLabel
    }()

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#0956FB")
        return bgView
    }()
    
    lazy var safeView: UIView = {
        let safeView = UIView()
        safeView.backgroundColor = UIColor.init(hexString: "#0956FB")
        return safeView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(safeView)
        addSubview(bgView)
        bgView.addSubview(backBtn)
        bgView.addSubview(nameLabel)
        
        safeView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(safeView.snp.bottom)
            make.height.equalTo(40.pix())
            make.bottom.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 22, height: 36))
            make.left.equalToSuperview().offset(17)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension H5HeadView {
    
    @objc func backBtnClick() {
        self.backBlock?()
    }
}
