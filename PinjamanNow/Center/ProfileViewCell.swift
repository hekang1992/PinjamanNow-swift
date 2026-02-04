//
//  ProfileViewCell.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/4.
//

import UIKit
import SnapKit
import Kingfisher

class ProfileViewCell: UITableViewCell {
    
    var model: entersomeModel? {
        didSet {
            guard let model = model else { return }
            logoImageView.kf.setImage(with: URL(string: model.ponder ?? ""))
            nameLabel.text = model.actionsome ?? ""
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "mic_list_image")
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        logoImageView.backgroundColor = .systemBlue
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#010204")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return nameLabel
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "right_li_a_image")
        return rightImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(rightImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 48.pix()))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(22)
            make.left.equalToSuperview().offset(15)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 12, height: 15))
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
