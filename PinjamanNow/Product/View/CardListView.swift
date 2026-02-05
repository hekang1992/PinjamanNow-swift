//
//  CardListView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit

class CardListView: UIView {
    
    var tapClickBlock: (() -> Void)?
    
    let languageCode = LanguageManager.current

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == .indonesian ? UIImage(named: "id_st_one_image") : UIImage(named: "en_st_one_image")
        return bgImageView
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = UIImage(named: "st_dex_image")
        return descImageView
    }()
    
    lazy var footView: UIView = {
        let footView = UIView()
        footView.layer.cornerRadius = 14
        footView.layer.masksToBounds = true
        footView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        footView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return footView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = languageCode == .indonesian ? "Tampak depan ktp" : "ID Card"
        nameLabel.textColor = UIColor.init(hexString: "#0956FB")
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return nameLabel
    }()
    
    lazy var aImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.image = UIImage(named: "casr_bg_a_image")
        return aImageView
    }()
    
    lazy var bImageView: UIImageView = {
        let bImageView = UIImageView()
        bImageView.image = UIImage(named: "nor_a_ca_image")
        return bImageView
    }()
    
    lazy var cImageView: UIImageView = {
        let cImageView = UIImageView()
        cImageView.image = languageCode == .indonesian ? UIImage(named: "id_st_desq_image") : UIImage(named: "en_st_desq_image")
        cImageView.contentMode = .scaleAspectFit
        return cImageView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.addTarget(self, action: #selector(clickBtnClick), for: .touchUpInside)
        return clickBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(bgImageView)
        scrollView.addSubview(descImageView)
        descImageView.addSubview(nameLabel)
        
        scrollView.addSubview(footView)
        scrollView.addSubview(aImageView)
        scrollView.addSubview(bImageView)
        scrollView.addSubview(cImageView)
        scrollView.addSubview(clickBtn)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 335.pix(), height: 60.pix()))
        }
        descImageView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 240.pix()))
        }
        footView.snp.makeConstraints { make in
            make.top.equalTo(descImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.pix())
            make.height.equalTo(295.pix())
            make.bottom.equalToSuperview().offset(-20.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42)
            make.left.equalToSuperview().offset(35)
            make.height.equalTo(16)
        }
        aImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descImageView.snp.top).offset(120.pix())
            make.size.equalTo(CGSize(width: 250.pix(), height: 166.pix()))
        }
        bImageView.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.top.right.equalTo(aImageView).inset(-15)
        }
        cImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 305.pix(), height: 205.pix()))
            make.top.equalTo(aImageView.snp.bottom).offset(29.pix())
        }
        clickBtn.snp.makeConstraints { make in
            make.top.left.right.equalTo(descImageView)
            make.bottom.equalTo(footView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CardListView {
    
    @objc func clickBtnClick() {
        self.tapClickBlock?()
    }
    
}
