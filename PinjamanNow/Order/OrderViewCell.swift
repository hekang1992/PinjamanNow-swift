//
//  OrderViewCell.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/4.
//

import UIKit
import SnapKit
import Kingfisher

class OrderViewCell: UITableViewCell {
    
    var model: argentficationModel? {
        didSet {
            guard let model = model else { return }
           
            let gamery = model.gamery ?? ""
            if gamery.isEmpty {
                bgView.snp.updateConstraints { make in
                    make.height.equalTo(160.pix())
                }
            }else {
                bgView.snp.updateConstraints { make in
                    make.height.equalTo(184.pix())
                }
            }
            footLabel.text = gamery
            footLabel.isHidden = gamery.isEmpty
            
            
            let vol = model.civsimplyfier?.vol ?? ""
            
            applyLabel.isHidden = vol.isEmpty ? true : false
            
            applyLabel.text = vol
            
            applyImageView.isHidden = vol.isEmpty ? true : false
            
            nameLabel.text = model.large ?? ""
            logoImageView.kf.setImage(with: URL(string: model.fensacious ?? ""))
            
            amcLabel.text = model.executiveable ?? ""
            amountLabel.text = model.affectoon ?? ""
            
            let igmillionical = model.igmillionical ?? ""
            let rachality = model.civsimplyfier?.rachality ?? ""
            
            timeLabel.text = String(format: "%@: %@", igmillionical, rachality)
            
            typeLabel.text = model.civsimplyfier?.purpurular ?? ""
            
            let exry = model.civsimplyfier?.exry ?? ""
            switch exry {
            case "vidacle":
                self.typeImageView.image = UIImage(named: "order_apply_image")
                
            case "serpian":
                self.typeImageView.image = UIImage(named: "order_rev_image")
                
            case "veneritor":
                self.typeImageView.image = UIImage(named: "order_comy_image")
                
            case "cumbance":
                self.typeImageView.image = UIImage(named: "order_rep_image")
                
            case "fugitdom":
                self.typeImageView.image = UIImage(named: "order_delay_image")
                
            default:
                break
            }
            
            
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var emoView: UIView = {
        let emoView = UIView()
        emoView.layer.cornerRadius = 12
        emoView.layer.masksToBounds = true
        emoView.backgroundColor = UIColor.init(hexString: "#F2F6FF")
        return emoView
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        return typeImageView
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textAlignment = .right
        typeLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        typeLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return typeLabel
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .right
        nameLabel.textColor = UIColor.init(hexString: "#010204")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return nameLabel
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var amcLabel: UILabel = {
        let amcLabel = UILabel()
        amcLabel.textAlignment = .left
        amcLabel.textColor = UIColor.init(hexString: "#B4B4B4")
        amcLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return amcLabel
    }()
    
    lazy var amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.textAlignment = .left
        amountLabel.textColor = UIColor.init(hexString: "#010204")
        amountLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return amountLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textAlignment = .left
        timeLabel.textColor = UIColor.init(hexString: "#B4B4B4")
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return timeLabel
    }()
    
    lazy var footLabel: UILabel = {
        let footLabel = UILabel()
        footLabel.textAlignment = .left
        footLabel.numberOfLines = 0
        footLabel.textColor = UIColor.init(hexString: "#FF5863")
        footLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return footLabel
    }()
    
    lazy var applyImageView: UIImageView = {
        let applyImageView = UIImageView()
        applyImageView.image = UIImage(named: "apply_bg_a_image")
        return applyImageView
    }()
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel()
        applyLabel.textAlignment = .center
        applyLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        applyLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return applyLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(emoView)
        contentView.addSubview(typeImageView)
        typeImageView.addSubview(typeLabel)
        emoView.addSubview(nameLabel)
        emoView.addSubview(logoImageView)
        emoView.addSubview(amcLabel)
        emoView.addSubview(amountLabel)
        emoView.addSubview(timeLabel)
        emoView.addSubview(applyImageView)
        applyImageView.addSubview(applyLabel)
        bgView.addSubview(footLabel)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.pix())
            make.height.equalTo(184.pix())
            make.bottom.equalToSuperview().offset(-10.pix())
        }
        emoView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(10.pix())
            make.height.equalTo(140.pix())
        }
        typeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.pix())
            make.left.equalToSuperview().offset(8.pix())
            make.height.equalTo(32)
        }
        typeLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(15)
            make.right.equalToSuperview().offset(-5)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(typeImageView)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(18)
        }
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(nameLabel.snp.left).offset(-5)
        }
        amcLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(53.pix())
            make.left.equalToSuperview().offset(15.pix())
            make.height.equalTo(12)
        }
        amountLabel.snp.makeConstraints { make in
            make.left.equalTo(amcLabel)
            make.top.equalTo(amcLabel.snp.bottom).offset(12)
            make.height.equalTo(18)
        }
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(amcLabel)
            make.top.equalTo(amountLabel.snp.bottom).offset(18)
            make.height.equalTo(13)
        }
        footLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-11.pix())
            make.left.equalToSuperview().offset(10.pix())
            make.centerX.equalToSuperview()
        }
        applyImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 108.pix(), height: 40.pix()))
        }
        applyLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
