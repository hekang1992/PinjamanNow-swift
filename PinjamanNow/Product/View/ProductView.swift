//
//  ProductView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit
import Kingfisher

class ProductView: UIView {
    
    var model: recordModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.popul?.fensacious ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.popul?.large ?? ""
            amountLabel.text = model.popul?.opportunityacle ?? ""
            descLabel.text = model.popul?.seniorot ?? ""
        }
    }
    
    var cellBlock: ((astyModel) -> Void)?
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "product_li_bg_image")
        return headImageView
    }()
    
    lazy var appHeadView: H5HeadView = {
        let appHeadView = H5HeadView()
        return appHeadView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProductViewCell.self, forCellReuseIdentifier: "ProductViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
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
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "home_desc_r_image")
        return rightImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.borderColor = UIColor.white.cgColor
        logoImageView.layer.cornerRadius = 7
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return nameLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headImageView)
        headImageView.addSubview(rightImageView)
        addSubview(appHeadView)
        addSubview(tableView)
        headImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(298.pix())
        }
        
        rightImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 143, height: 167))
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        appHeadView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(appHeadView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProductView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 230.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.addSubview(logoImageView)
        headView.addSubview(nameLabel)
        headView.addSubview(amountLabel)
        headView.addSubview(mcmImageView)
        mcmImageView.addSubview(descLabel)
        logoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(22)
            make.width.height.equalTo(34)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.height.equalTo(20)
            make.left.equalTo(logoImageView.snp.right).offset(12)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(27)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(50)
        }
        mcmImageView.snp.makeConstraints { make in
            make.left.equalTo(amountLabel)
            make.top.equalTo(amountLabel.snp.bottom).offset(13)
            make.size.equalTo(CGSize(width: 226, height: 34))
        }
        descLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(34)
        }
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.asty?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductViewCell", for: indexPath) as! ProductViewCell
        let listModel = self.model?.asty?[indexPath.row]
        cell.model = listModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let listModel = self.model?.asty?[indexPath.row] {
            self.cellBlock?(listModel)
        }
    }
    
}
