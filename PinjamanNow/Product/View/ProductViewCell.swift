//
//  ProductViewCell.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit
import Kingfisher

class ProductViewCell: UITableViewCell {
    
    var model: astyModel? {
        didSet {
            guard let model = model else { return }
            let meria = model.meria ?? 0
            typeImageView.image = meria == 1 ? UIImage(named: "cer_sel_image") : UIImage(named: "cer_not_image")
            nameLabel.text = model.actionsome ?? ""
            
            let emesiaire = model.emesiaire ?? ""
            
            
            descLabel.textColor = meria == 1 ? UIColor.init(hexString: "#0956FB") : UIColor.init(hexString: "#B4B4B4")
            
            let typestr = model.bestlike ?? ""
            
            descLabel.text = meria == 1 ? typestr : emesiaire
            
            logoImageView.kf.setImage(with: URL(string: model.pinier ?? ""))
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pc_de_mo_image")
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
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.init(hexString: "#B4B4B4")
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return descLabel
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        typeImageView.image = UIImage(named: "cer_not_image")
        return typeImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(typeImageView)
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 65.pix()))
            make.bottom.equalToSuperview().offset(-15.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
            make.left.equalToSuperview().offset(15)
        }
        typeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
            make.right.equalToSuperview().offset(-20.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(logoImageView.snp.right).offset(9)
            make.height.equalTo(18)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.left.equalTo(logoImageView.snp.right).offset(9)
            make.right.equalToSuperview().offset(-55.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
