//
//  CompleteCardListView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/7.
//

import UIKit
import SnapKit

class CompleteCardListView: UIView {
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.layer.cornerRadius = 8
        oneView.layer.masksToBounds = true
        oneView.backgroundColor = UIColor.init(hexString: "#F2F6FF")
        return oneView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.textColor = UIColor.init(hexString: "#010204")
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return nameLabel
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "rcp_fa_image")
        return bgImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(oneView)
        oneView.addSubview(nameLabel)
        oneView.addSubview(bgImageView)
        
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-40)
        }
        bgImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 16, height: 14))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
