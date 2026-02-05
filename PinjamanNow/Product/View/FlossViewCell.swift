//
//  FlossViewCell.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit

class FlossViewCell: UITableViewCell {
    
    var model: fragthoughiceModel? {
        didSet {
            guard let model = model else { return }
            oneLabel.text = model.tenuess ?? ""
            nameLabel.text = model.pauchundredot ?? ""
            enterFiled.placeholder = model.fugable ?? ""
            
            phoneLabel.text = model.withify ?? ""
            phoneFiled.placeholder = model.westernarian ?? ""
            
            let ethnesque = model.ethnesque ?? ""
            let typeArray = model.whateverfic ?? []
            for model in typeArray {
                let target = model.provide ?? ""
                if ethnesque == target {
                    enterFiled.text = model.sy ?? ""
                }
            }
            
            
            let name = model.sy ?? ""
            let phone = model.selfopen ?? ""
            
            phoneFiled.text = phone.isEmpty ? "" : String(format: "%@:%@", name, phone)
        }
    }
    
    var relationBlock: (() -> Void)?
    
    var phoneBlock: (() -> Void)?
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "flo_name_image")
        return oneImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        return bgView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .center
        oneLabel.textColor = UIColor.init(hexString: "#010204")
        oneLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return oneLabel
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "listd_car_d_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#010204")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    lazy var enterFiled: UITextField = {
        let enterFiled = UITextField()
        enterFiled.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        enterFiled.textColor = UIColor.init(hexString: "#010204")
        return enterFiled
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "rc_arwo_image")
        return arrowImageView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.addTarget(self, action: #selector(relationClick), for: .touchUpInside)
        return clickBtn
    }()
    
    lazy var phoneImageView: UIImageView = {
        let phoneImageView = UIImageView()
        phoneImageView.image = UIImage(named: "listd_car_d_image")
        phoneImageView.isUserInteractionEnabled = true
        return phoneImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textAlignment = .left
        phoneLabel.textColor = UIColor.init(hexString: "#010204")
        phoneLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return phoneLabel
    }()
    
    lazy var phoneFiled: UITextField = {
        let phoneFiled = UITextField()
        phoneFiled.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        phoneFiled.textColor = UIColor.init(hexString: "#010204")
        return phoneFiled
    }()
    
    lazy var phoneArrowImageView: UIImageView = {
        let phoneArrowImageView = UIImageView()
        phoneArrowImageView.image = UIImage(named: "rc_arwo_image")
        return phoneArrowImageView
    }()
    
    lazy var phoneBtn: UIButton = {
        let phoneBtn = UIButton(type: .custom)
        phoneBtn.addTarget(self, action: #selector(phoneClick), for: .touchUpInside)
        return phoneBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(oneImageView)
        oneImageView.addSubview(oneLabel)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(15.pix())
            make.height.equalTo(245.pix())
            make.bottom.equalToSuperview().offset(-20.pix())
        }
        oneImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 148.pix(), height: 38.pix()))
        }
        oneLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(enterFiled)
        bgImageView.addSubview(arrowImageView)
        bgImageView.addSubview(clickBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 315.pix(), height: 88.pix()))
            make.top.equalTo(oneImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
            make.height.equalTo(15)
        }
        enterFiled.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-30)
        }
        arrowImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 11, height: 15))
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-18)
        }
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(phoneImageView)
        phoneImageView.addSubview(phoneLabel)
        phoneImageView.addSubview(phoneFiled)
        phoneImageView.addSubview(phoneArrowImageView)
        phoneImageView.addSubview(phoneBtn)
        
        phoneImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 315.pix(), height: 88.pix()))
            make.top.equalTo(bgImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        phoneLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
            make.height.equalTo(15)
        }
        phoneFiled.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(phoneLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-30)
        }
        phoneArrowImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 11, height: 15))
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-18)
        }
        phoneBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlossViewCell {
    
    @objc func relationClick() {
        self.relationBlock?()
    }
    
    @objc func phoneClick() {
        self.phoneBlock?()
    }
    
}
