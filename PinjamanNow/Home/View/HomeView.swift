//
//  HomeView.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/3.
//

import UIKit
import SnapKit
import Kingfisher

class HomeView: UIView {
    
    var clickBlock: ((phalarModel) -> Void)?
    
    var serviceBlock: (() -> Void)?
    
    var loanBlock: (() -> Void)?
    
    private let languageCode = LanguageManager.current
    
    var model: phalarModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.fensacious ?? ""
            self.headView.logoImageView.kf.setImage(with: URL(string: logoUrl))
            self.headView.nameLabel.text = model.large ?? ""
            amountLabel.text = model.directoro ?? ""
            descLabel.text = model.legis ?? ""
            let cribr = model.cribr ?? ""
            let beginid = model.beginid ?? ""
            oneBtn.setTitle("\(cribr): \(beginid)", for: .normal)
            
            let plaudine = model.plaudine ?? ""
            let clearlyward = model.clearlyward ?? ""
            twoBtn.setTitle("\(plaudine): \(clearlyward)", for: .normal)
            
            self.applyView.applyBtn.setTitle(model.sorc ?? "", for: .normal)
            
            onefooterView.model = model
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "sy_one_bg_image")
        return bgImageView
    }()
    
    lazy var headView: HomeHeadView = {
        let headView = HomeHeadView(frame: .zero)
        return headView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.textAlignment = .left
        amountLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        amountLabel.font = UIFont.systemFont(ofSize: 54, weight: .bold)
        return amountLabel
    }()
    
    lazy var mcmImageView: UIImageView = {
        let mcmImageView = UIImageView()
        mcmImageView.image = UIImage(named: "cycl_a_image")
        return mcmImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return descLabel
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setTitleColor(.white, for: .normal)
        oneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        oneBtn.setImage(UIImage(named: "home_cyl_image"), for: .normal)
        let spacing: CGFloat = 15
        oneBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        oneBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setTitleColor(.white, for: .normal)
        twoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        twoBtn.setImage(UIImage(named: "home_cyl_image"), for: .normal)
        let spacing: CGFloat = 15
        twoBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        twoBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        return twoBtn
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "home_desc_r_image")
        return rightImageView
    }()

    lazy var applyView: HomeApplyView = {
        let applyView = HomeApplyView(frame: .zero)
        applyView.backgroundColor = .white
        applyView.clickBlock = { [weak self] in
            guard let self = self, let model = model else { return }
            self.clickBlock?(model)
        }
        applyView.loanBlock = { [weak self] in
            self?.loanBlock?()
        }
        return applyView
    }()
    
    lazy var idFootImageView: UIImageView = {
        let idFootImageView = UIImageView()
        idFootImageView.image = UIImage(named: "id_fot_de_image")
        return idFootImageView
    }()
    
    lazy var bannerView: HomeDescBannerView = {
        let bannerView = HomeDescBannerView()
        return bannerView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "ec_fot_de_image")
        return threeImageView
    }()
    
    lazy var onefooterView: HomeOneFootView = {
        let onefooterView = HomeOneFootView()
        onefooterView.tapBlock = { [weak self] model in
            self?.clickBlock?(model)
        }
        return onefooterView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(rightImageView)
        addSubview(headView)
        addSubview(scrollView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(352.pix())
        }
        rightImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 143, height: 167))
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        headView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        scrollView.addSubview(amountLabel)
        scrollView.addSubview(mcmImageView)
        mcmImageView.addSubview(descLabel)
        scrollView.addSubview(oneBtn)
        scrollView.addSubview(twoBtn)
        scrollView.addSubview(applyView)
        amountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        mcmImageView.snp.makeConstraints { make in
            make.left.equalTo(amountLabel)
            make.top.equalTo(amountLabel.snp.bottom).offset(13)
            make.size.equalTo(CGSize(width: 226, height: 34))
        }
        descLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(34)
        }
        oneBtn.snp.makeConstraints { make in
            make.left.equalTo(amountLabel)
            make.top.equalTo(descLabel.snp.bottom).offset(28)
            make.height.equalTo(14)
        }
        
        twoBtn.snp.makeConstraints { make in
            make.left.equalTo(amountLabel)
            make.top.equalTo(oneBtn.snp.bottom).offset(20)
            make.height.equalTo(14)
        }
        applyView.snp.makeConstraints { make in
            make.top.equalTo(twoBtn.snp.bottom).offset(44.pix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(languageCode == .indonesian ? 207 : 242)
        }
        
        if languageCode == .indonesian {
            scrollView.addSubview(idFootImageView)
            idFootImageView.snp.makeConstraints { make in
                make.top.equalTo(applyView.snp.bottom).offset(15.pix())
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 335.pix(), height: 114.pix()))
                make.bottom.equalToSuperview().offset(-90.pix())
            }
        }else {
            scrollView.addSubview(bannerView)
            scrollView.addSubview(threeImageView)
            scrollView.addSubview(onefooterView)
            bannerView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(applyView.snp.bottom).offset(16)
                make.left.equalToSuperview()
                make.height.equalTo(166.pix())
            }
            threeImageView.snp.makeConstraints { make in
                make.top.equalTo(bannerView.snp.bottom).offset(20.pix())
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 335.pix(), height: 114.pix()))
            }
            onefooterView.snp.makeConstraints { make in
                make.top.equalTo(threeImageView.snp.bottom).offset(10.pix())
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 335.pix(), height: 70.pix()))
                make.bottom.equalToSuperview().offset(-90.pix())
            }
        }
        
        headView.serviceBlock = { [weak self] in
            self?.serviceBlock?()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
