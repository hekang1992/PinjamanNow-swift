//
//  HomeApplyView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/4.
//

import UIKit
import SnapKit

class HomeApplyView: UIView {
    
    var clickBlock: (() -> Void)?
    
    var loanBlock: (() -> Void)?
    
    private let languageCode = LanguageManager.current
    
    lazy var descBtn: UIButton = {
        let descBtn = UIButton(type: .custom)
        descBtn.setTitleColor(UIColor.init(hexString: "#010204"), for: .normal)
        descBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        descBtn.setImage(UIImage(named: "sy_bz_ic"), for: .normal)
        descBtn.setTitle(languageCode == .indonesian ? "Proses aplikasi" : "Application process", for: .normal)
        let spacing: CGFloat = 15
        descBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        descBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        return descBtn
    }()
    
    lazy var stepImageView: UIImageView = {
        let stepImageView = UIImageView()
        stepImageView.image = languageCode == .indonesian ?
        UIImage(named: "ed_st_li_image") :
        UIImage(named: "en_st_li_image")
        return stepImageView
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.isSelected = true
        sureBtn.setImage(UIImage(named: "login_tc_xz_image"), for: .normal)
        sureBtn.setImage(UIImage(named: "login_tc_sel_image"), for: .selected)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        return sureBtn
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        applyBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        applyBtn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        return applyBtn
    }()
    
    private lazy var clickableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        
        let fullText = "I have read and agreed to the <Loan terms>"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0, length: fullText.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.init(hexString: "#010204") as Any, range: NSRange(location: 0, length: fullText.count))
        
        let privacyRange = (fullText as NSString).range(of: "<Loan terms>")
        
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hexString: "#0956FB") as Any
        ]
        
        attributedString.addAttributes(linkAttributes, range: privacyRange)
        
        label.attributedText = attributedString
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        label.addGestureRecognizer(tapGesture)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(descBtn)
        addSubview(stepImageView)
        descBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(16)
        }
        stepImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 335.pix(), height: 55.pix()))
            make.top.equalTo(descBtn.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        if languageCode == .english {
            addSubview(sureBtn)
            addSubview(clickableLabel)
            
            sureBtn.snp.makeConstraints { make in
                make.width.height.equalTo(14.pix())
                make.left.equalToSuperview().offset(20)
                make.top.equalTo(stepImageView.snp.bottom).offset(20)
            }
            
            clickableLabel.snp.makeConstraints { make in
                make.centerY.equalTo(sureBtn)
                make.left.equalTo(sureBtn.snp.right).offset(8)
                make.height.equalTo(14)
            }
            
        }
        addSubview(applyBtn)
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 315.pix(), height: 55.pix()))
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeApplyView {
    
    @objc func sureBtnClick() {
        sureBtn.isSelected.toggle()
    }
    
    @objc func applyBtnClick() {
        self.clickBlock?()
    }
    
    @objc private func labelTapped(_ gesture: UITapGestureRecognizer) {
        self.loanBlock?()
    }
    
}
