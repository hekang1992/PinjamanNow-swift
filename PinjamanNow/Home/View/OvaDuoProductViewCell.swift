//
//  OvaDuoProductViewCell.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/6.
//

import UIKit
import SnapKit
import Kingfisher

class OvaDuoProductViewCell: UITableViewCell {
    
    var tapClickBlock: ((phalarModel) -> Void)?
    
    var model: phalarModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.fensacious ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.large ?? ""
            rateLabel.text = model.ficactuallyence ?? ""
            oneLabel.text = model.legis ?? ""
            moneyLabel.text = model.directoro ?? ""
            applyBtn.setTitle(model.sorc ?? "", for: .normal)
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 8
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#010204")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return nameLabel
    }()
    
    lazy var rateLabel: UILabel = {
        let rateLabel = UILabel()
        rateLabel.textAlignment = .left
        rateLabel.textColor = UIColor.init(hexString: "#0956FB")
        rateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return rateLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#B4B4B4")
        oneLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return oneLabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textAlignment = .left
        moneyLabel.textColor = UIColor.init(hexString: "#010204")
        moneyLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return moneyLabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        applyBtn.setBackgroundImage(UIImage(named: "apc_b_t_image"), for: .normal)
        applyBtn.isUserInteractionEnabled = false
        applyBtn.titleLabel?.numberOfLines = 0
        applyBtn.titleLabel?.textAlignment = .center
        return applyBtn
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        tapBtn.addTarget(self, action: #selector(tapClick), for: .touchUpInside)
        return tapBtn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(rateLabel)
        
        bgView.addSubview(oneLabel)
        bgView.addSubview(moneyLabel)
        bgView.addSubview(applyBtn)
        
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 100.pix()))
            make.bottom.equalToSuperview().offset(-15.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(15)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalTo(logoImageView.snp.right).offset(14)
            make.height.equalTo(18)
        }
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.left.equalTo(nameLabel)
            make.height.equalTo(15)
        }
        oneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-19)
            make.height.equalTo(11)
        }
        moneyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(oneLabel)
            make.left.equalTo(oneLabel.snp.right).offset(8)
            make.height.equalTo(18)
        }
        applyBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 108.pix(), height: 40.pix()))
        }
        
        contentView.addSubview(tapBtn)
        tapBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension OvaDuoProductViewCell {
    
    @objc func tapClick() {
        if let model = model {
            self.tapClickBlock?(model)
        }
    }
    
}
