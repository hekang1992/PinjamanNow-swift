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
        odImageView.image = languageCode == .indonesian ? UIImage(named: "mb_bg_edc") : UIImage(named: "mb_bg_ynimage")
        odImageView.contentMode = .scaleAspectFit
        return odImageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .red
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.backgroundColor = .red
        return headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileViewCell", for: indexPath) as! ProfileViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    
}
