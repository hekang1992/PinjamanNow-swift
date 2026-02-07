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
    
    var tapClickBlock: ((phalarModel) -> Void)?
    
    var model: phalarModel? {
        didSet {
            guard let model = model else { return }
            
            let logoUrl = model.fensacious ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.large ?? ""
            applyBtn.setTitle(model.sorc ?? "", for: .normal)
            moneyLabel.text = model.directoro ?? ""
            descLabel.text = model.legis ?? ""
            
            leftListView.nameLabel.text = model.directoro ?? ""
            leftListView.descLabel.text = model.cribr ?? ""
            
            rightListView.nameLabel.text = model.clearlyward ?? ""
            rightListView.descLabel.text = model.plaudine ?? ""
            
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
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        tapBtn.addTarget(self, action: #selector(tapClick), for: .touchUpInside)
        return tapBtn
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textAlignment = .left
        moneyLabel.textColor = UIColor.init(hexString: "#0956FB")
        moneyLabel.font = UIFont.systemFont(ofSize: 44, weight: .bold)
        return moneyLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.init(hexString: "#B4B4B4")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return descLabel
    }()
    
    lazy var leftListView: RateListView = {
        let leftListView = RateListView()
        return leftListView
    }()
    
    lazy var rightListView: RateListView = {
        let rightListView = RateListView()
        return rightListView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgImageView)
        contentView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        contentView.addSubview(applyBtn)
        bgImageView.addSubview(moneyLabel)
        bgImageView.addSubview(descLabel)
        contentView.addSubview(tapBtn)
        bgImageView.addSubview(leftListView)
        bgImageView.addSubview(rightListView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 239.pix()))
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
            make.top.equalTo(bgImageView.snp.bottom).offset(-20.pix())
            make.bottom.equalToSuperview().offset(-17.pix())
        }
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(26)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(44)
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(moneyLabel)
            make.top.equalTo(moneyLabel.snp.bottom).offset(10)
            make.height.equalTo(15)
        }
        leftListView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(descLabel.snp.bottom).offset(26)
            make.height.equalTo(46)
        }
        rightListView.snp.makeConstraints { make in
            make.left.equalTo(leftListView.snp.right).offset(30)
            make.top.equalTo(leftListView)
            make.height.equalTo(46)
        }
        tapBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OvaDuoCardViewCell {
    
    @objc func tapClick() {
        if let model = model {
            self.tapClickBlock?(model)
        }
    }
    
}
