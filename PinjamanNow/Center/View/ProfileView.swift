//
//  ProfileView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
    let languageCode = LanguageManager.current
    
    var listArray: [entersomeModel] = []
    
    var cellBlock: ((entersomeModel) -> Void)?
    
    var tapClickBlock: ((String) -> Void)?
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        return whiteView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "profile_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "profile_per_image")
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = languageCode == .indonesian ? "Akun" : "Profile"
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return nameLabel
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.text = LoginManager.shared.getPhone()
        phoneLabel.textAlignment = .left
        phoneLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        phoneLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return phoneLabel
    }()
    
    lazy var odImageView: UIImageView = {
        let odImageView = UIImageView()
        odImageView.image = languageCode == .indonesian ? UIImage(named: "mb_bg_ynimage") : UIImage(named: "mb_bg_edc")
        odImageView.contentMode = .scaleAspectFit
        odImageView.isUserInteractionEnabled = true
        return odImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.addTarget(self, action: #selector(oneBtnClick), for: .touchUpInside)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.addTarget(self, action: #selector(twoBtnClick), for: .touchUpInside)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.addTarget(self, action: #selector(threeBtnClick), for: .touchUpInside)
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        fourBtn.addTarget(self, action: #selector(fourBtnClick), for: .touchUpInside)
        return fourBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProfileViewCell.self, forCellReuseIdentifier: "ProfileViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(whiteView)
        whiteView.addSubview(bgImageView)
        whiteView.addSubview(odImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(phoneLabel)
        bgImageView.addSubview(nameLabel)
        addSubview(tableView)
        
        whiteView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(365.pix())
        }
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(193.pix())
        }
        odImageView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 132.pix()))
        }
        logoImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-42.pix())
            make.size.equalTo(CGSize(width: 89.pix(), height: 125.pix()))
        }
        phoneLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-30)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(phoneLabel)
            make.height.equalTo(28)
            make.bottom.equalTo(phoneLabel.snp.top).offset(-17)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(whiteView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-70)
        }
        odImageView.addSubview(oneBtn)
        odImageView.addSubview(twoBtn)
        odImageView.addSubview(threeBtn)
        odImageView.addSubview(fourBtn)
        
        oneBtn.snp.makeConstraints { make in
            make.right.left.top.equalToSuperview()
            make.height.equalTo(40.pix())
        }
        twoBtn.snp.makeConstraints { make in
            make.top.equalTo(oneBtn.snp.bottom)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 106.pix(), height: 99.pix()))
        }
        threeBtn.snp.makeConstraints { make in
            make.top.equalTo(oneBtn.snp.bottom)
            make.left.equalTo(twoBtn.snp.right).offset(9.pix())
            make.size.equalTo(CGSize(width: 106.pix(), height: 99.pix()))
        }
        fourBtn.snp.makeConstraints { make in
            make.top.equalTo(oneBtn.snp.bottom)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 106.pix(), height: 99.pix()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "flower_ac_image")
        
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = languageCode == .indonesian ? "Fungsi yang umum digunakan" : "Commonly used functions"
        nameLabel.textColor = UIColor.init(hexString: "#010204")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        headView.addSubview(logoImageView)
        headView.addSubview(nameLabel)
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(18)
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(18.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.height.equalTo(20)
        }
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileViewCell", for: indexPath) as! ProfileViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let model = listArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = listArray[indexPath.row]
        self.cellBlock?(model)
    }
    
}

extension ProfileView {
    
    @objc func oneBtnClick() {
        self.tapClickBlock?("1")
    }
    
    @objc func twoBtnClick() {
        self.tapClickBlock?("2")
    }
    
    @objc func threeBtnClick() {
        self.tapClickBlock?("3")
    }
    
    @objc func fourBtnClick() {
        self.tapClickBlock?("4")
    }
    
}
