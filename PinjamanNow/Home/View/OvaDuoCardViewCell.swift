//
//  OvaDuoCardViewCell.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/6.
//

import UIKit
import SnapKit
import Kingfisher

class OvaDuoCardViewCell: UITableViewCell {
    
    var model: phalarModel? {
        didSet {
            guard let model = model else { return }
            
            let logoUrl = model.fensacious ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.large ?? ""
            applyBtn.setTitle(model.sorc ?? "", for: .normal)
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "duo_cardbg_image")
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 10
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.borderWidth = 1.5
        logoImageView.layer.borderColor = UIColor.white.cgColor
        return logoImageView
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#010204")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return nameLabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        applyBtn.setBackgroundImage(UIImage(named: "duo_apb_image"), for: .normal)
        applyBtn.isUserInteractionEnabled = false
        return applyBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgImageView)
        contentView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        contentView.addSubview(applyBtn)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 239.pix()))
            make.bottom.equalToSuperview().offset(-47.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25.pix())
            make.left.equalTo(bgImageView.snp.left).offset(20)
            make.width.height.equalTo(52.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.bottom.equalTo(logoImageView)
            make.height.equalTo(19)
        }
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 287.pix(), height: 55.pix()))
            make.bottom.equalToSuperview().offset(-17.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
