//
//  OvaltineViewCell.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit

class OvaltineViewCell: UITableViewCell {
    
    var model: fragthoughiceModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.actionsome ?? ""
            enterFiled.placeholder = model.emesiaire ?? ""
            let type = model.be ?? ""
            clickBtn.isHidden = type == "myzchargeship" ? true : false
            arrowImageView.isHidden = type == "myzchargeship" ? true : false
            
            enterFiled.isEnabled = type == "myzchargeship" ? true : false
            
            let herator = model.herator ?? ""
            enterFiled.keyboardType = herator == "1" ? .numberPad : .default
            
            let value = model.executiveitious ?? ""
            enterFiled.text = value
            
        }
    }
    
    var tapBlock: (() -> Void)?
    
    var editBlock: ((String) -> Void)?
    
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
        arrowImageView.isHidden = true
        return arrowImageView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.addTarget(self, action: #selector(sureClick), for: .touchUpInside)
        clickBtn.isHidden = true
        return clickBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(enterFiled)
        bgImageView.addSubview(arrowImageView)
        bgImageView.addSubview(clickBtn)
        bgImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 315.pix(), height: 88.pix()))
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15.pix())
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
        setupTextFieldObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OvaltineViewCell {
    
    private func setupTextFieldObserver() {
        enterFiled.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        editBlock?(text)
    }
    
    @objc func sureClick() {
        self.tapBlock?()
    }
    
}
