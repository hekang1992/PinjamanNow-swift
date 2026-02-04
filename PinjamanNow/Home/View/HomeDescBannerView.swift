//
//  HomeDescBannerView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/4.
//

import UIKit
import SnapKit

class HomeDescBannerView: UIView {

    private let languageCode = LanguageManager.current
    
    lazy var descBtn: UIButton = {
        let descBtn = UIButton(type: .custom)
        descBtn.setImage(UIImage(named: "oth_de_image"), for: .normal)
        return descBtn
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "banner_one_image")
        oneImageView.contentMode = .scaleAspectFill
        oneImageView.clipsToBounds = true
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "banner_two_image")
        twoImageView.contentMode = .scaleAspectFill
        twoImageView.clipsToBounds = true
        return twoImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(descBtn)
        addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        containerView.addSubview(oneImageView)
        containerView.addSubview(twoImageView)
    }
    
    private func setupConstraints() {
        let itemWidth = 335.pix()
        let itemHeight = 118.pix()
        
        descBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(18)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(descBtn.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: itemWidth, height: itemHeight))
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(itemHeight)
            make.width.equalTo(itemWidth * 2)
        }
        
        oneImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(itemWidth)
        }
        
        twoImageView.snp.makeConstraints { make in
            make.left.equalTo(oneImageView.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(itemWidth)
        }
    }
}
