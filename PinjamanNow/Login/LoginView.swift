//
//  LoginView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    var codeBlock: (() -> Void)?
    
    var loginBlock: (() -> Void)?
    
    var bacaBlock: (() -> Void)?
    
    let languageCode = LanguageManager.current
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "login_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "login_bg_logo")
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = languageCode == .indonesian ? UIImage(named: "login_desc_id_image") : UIImage(named: "login_desc_btn_image")
        descImageView.contentMode = .scaleAspectFit
        return descImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.text = languageCode == .indonesian ? "Nomor telepon" : "Phone Number"
        oneLabel.textColor = UIColor.init(hexString: "#010204")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return oneLabel
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.layer.cornerRadius = 12
        oneView.layer.masksToBounds = true
        oneView.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        return oneView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setTitle(languageCode == .indonesian ? "+62" : "+91", for: .normal)
        oneBtn.setTitleColor(UIColor.init(hexString: "#010204"), for: .normal)
        oneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        oneBtn.setImage(UIImage(named: "login_ic_phone"), for: .normal)
        oneBtn.semanticContentAttribute = .forceLeftToRight
        oneBtn.isSelected = false
        let spacing: CGFloat = 8
        oneBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        oneBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
        oneBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        return oneBtn
    }()
    
    lazy var phoneFiled: UITextField = {
        let phoneFiled = UITextField()
        let placeholderText = languageCode == .indonesian ? "Nomor telepon" : "Phone number"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hexString: "#B4B4B4") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ]
        phoneFiled.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: attributes
        )
        phoneFiled.keyboardType = .numberPad
        phoneFiled.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        phoneFiled.textColor = UIColor.init(hexString: "#010204")
        return phoneFiled
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.text = languageCode == .indonesian ? "Nomor telepon" : "Phone Number"
        twoLabel.textColor = UIColor.init(hexString: "#010204")
        twoLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return twoLabel
    }()
    
    lazy var twoView: UIView = {
        let twoView = UIView()
        twoView.layer.cornerRadius = 12
        twoView.layer.masksToBounds = true
        twoView.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        return twoView
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setImage(UIImage(named: "login_ic_code"), for: .normal)
        return twoBtn
    }()
    
    lazy var codeFiled: UITextField = {
        let codeFiled = UITextField()
        let placeholderText = languageCode == .indonesian ? "Kode verifikasi" : "Verification Code"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hexString: "#B4B4B4") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ]
        codeFiled.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: attributes
        )
        codeFiled.keyboardType = .numberPad
        codeFiled.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        codeFiled.textColor = UIColor.init(hexString: "#010204")
        return codeFiled
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.setTitle(languageCode == .indonesian ? "Kirim kode" : "Get code", for: .normal)
        codeBtn.setTitleColor(UIColor.init(hexString: "#0956FB"), for: .normal)
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        codeBtn.addTarget(self, action: #selector(codeBtnClick), for: .touchUpInside)
//        codeBtn.contentHorizontalAlignment = .right
        return codeBtn
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.layer.cornerRadius = 1
        lineView.layer.masksToBounds = true
        lineView.backgroundColor = UIColor.init(hexString: "#0956FB")
        return lineView
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.isSelected = true
        sureBtn.setImage(UIImage(named: "login_tc_xz_image"), for: .normal)
        sureBtn.setImage(UIImage(named: "login_tc_sel_image"), for: .selected)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        return sureBtn
    }()
    
    private lazy var clickableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        
        let fullText = languageCode == .indonesian ? "Baca dan setujui <Perjanjian Privasi>" : "Read and agree to the <Privacy Agreement>"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0, length: fullText.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.init(hexString: "#010204") as Any, range: NSRange(location: 0, length: fullText.count))
        
        let privacyRange = (fullText as NSString).range(of: languageCode == .indonesian ? "<Perjanjian Privasi>" : "<Privacy Agreement>")
        
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hexString: "#0956FB") as Any,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        attributedString.addAttributes(linkAttributes, range: privacyRange)
        
        label.attributedText = attributedString
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        label.addGestureRecognizer(tapGesture)
        
        return label
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle(languageCode == .indonesian ? "Masuk" : "Log in", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        loginBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        return loginBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(logoImageView)
        addSubview(descImageView)
        addSubview(scrollView)
        scrollView.addSubview(oneLabel)
        scrollView.addSubview(oneView)
        oneView.addSubview(oneBtn)
        oneView.addSubview(phoneFiled)
        
        scrollView.addSubview(twoLabel)
        scrollView.addSubview(twoView)
        twoView.addSubview(twoBtn)
        twoView.addSubview(codeFiled)
        
        twoView.addSubview(codeBtn)
        codeBtn.addSubview(lineView)
        
        scrollView.addSubview(sureBtn)
        scrollView.addSubview(clickableLabel)
        scrollView.addSubview(loginBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(304.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(70)
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
        }
        descImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            if languageCode == .indonesian {
                make.size.equalTo(CGSize(width: 309, height: 56))
            }else {
                make.size.equalTo(CGSize(width: 286, height: 42))
            }
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(descImageView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        oneLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.top.equalToSuperview().offset(65)
            make.left.equalToSuperview().offset(30)
        }
        oneView.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(15)
            make.left.equalTo(oneLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        oneBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(8.pix())
            make.size.equalTo(CGSize(width: 69, height: 40))
        }
        phoneFiled.snp.makeConstraints { make in
            make.left.equalTo(oneBtn.snp.right)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-5.pix())
        }
        
        twoLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.top.equalTo(oneView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(30)
        }
        twoView.snp.makeConstraints { make in
            make.top.equalTo(twoLabel.snp.bottom).offset(15)
            make.left.equalTo(twoLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        twoBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        codeFiled.snp.makeConstraints { make in
            make.left.equalTo(twoBtn.snp.right).offset(10)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-120.pix())
        }
        codeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            if languageCode == .indonesian {
                make.size.equalTo(CGSize(width: 75, height: 14))
            }else {
                make.size.equalTo(CGSize(width: 65, height: 14))
            }
        }
        
        lineView.snp.makeConstraints { make in
            make.left.right.equalTo(codeBtn)
            make.bottom.equalToSuperview().offset(1)
            make.height.equalTo(1)
        }
        
        sureBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.width.height.equalTo(14.pix())
            make.top.equalTo(twoView.snp.bottom).offset(33)
        }
        clickableLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sureBtn)
            make.left.equalTo(sureBtn.snp.right).offset(5)
            make.height.equalTo(14)
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(clickableLabel.snp.bottom).offset(20.pix())
            make.size.equalTo(CGSize(width: 315.pix(), height: 55.pix()))
            make.bottom.equalToSuperview().offset(-20.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView {
    
    @objc func sureBtnClick() {
        sureBtn.isSelected.toggle()
    }
    
    @objc func codeBtnClick() {
        self.codeBlock?()
    }
    
    @objc func loginBtnClick() {
        self.loginBlock?()
    }
    
    @objc private func labelTapped(_ gesture: UITapGestureRecognizer) {
        self.bacaBlock?()
    }
    
}
