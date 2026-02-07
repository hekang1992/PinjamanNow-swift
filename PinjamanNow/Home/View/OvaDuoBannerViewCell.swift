//
//  OvaDuoBannerViewCell.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/6.
//

import UIKit
import SnapKit
import FSPagerView

class OvaDuoBannerViewCell: UITableViewCell {
    
    var tapBlock: ((phalarModel) -> Void)?
    
    var modelArray: [phalarModel]? {
        didSet {
            pagerView.reloadData()
        }
    }
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        return view
    }()
    
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(CustomPagerCell.self, forCellWithReuseIdentifier: "CustomPagerCell")
        pagerView.interitemSpacing = 5
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 3.0
        pagerView.backgroundColor = .clear
        pagerView.layer.borderWidth = 0
        return pagerView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "lid_fa_image")
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = "Pengingat Pemberitahuan"
        nameLabel.textColor = UIColor.init(hexString: "#010204")
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgView.addSubview(nameLabel)
        
        bgView.addSubview(pagerView)
        
    }
    
    private func setupConstraints() {
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 82.pix()))
            make.bottom.equalToSuperview()
        }
        
        bgImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(15)
            make.size.equalTo(CGSize(width: 12, height: 15))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(bgImageView)
            make.left.equalTo(bgImageView.snp.right).offset(5)
            make.height.equalTo(15)
        }
        
        pagerView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalToSuperview().offset(13)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
    }
}

extension OvaDuoBannerViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return modelArray?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(
            withReuseIdentifier: "CustomPagerCell",
            at: index
        ) as! CustomPagerCell
        
        if let model = modelArray?[index] {
            cell.titleLabel.text = model.calcfootment ?? ""
        }
        self.cellPara(with: cell)
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        guard let model = modelArray?[index] else { return }
        tapBlock?(model)
    }
    
    private func cellPara(with cell: CustomPagerCell) {
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        cell.contentView.layer.shadowRadius = 0
        cell.contentView.layer.shadowOpacity = 0
        cell.contentView.layer.shadowOffset = .zero
        
        cell.contentView.transform = CGAffineTransform.identity
        
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
    }
}

class CustomPagerCell: FSPagerViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#B4B4B4")
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
