//
//  OvaDuoView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/6.
//

import UIKit
import SnapKit

class OvaDuoView: UIView {
    
    var modelArray: [argentficationModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OvaDuoCardViewCell.self, forCellReuseIdentifier: "OvaDuoCardViewCell")
        tableView.register(OvaDuoBannerViewCell.self, forCellReuseIdentifier: "OvaDuoBannerViewCell")
        tableView.register(OvaDuoProductViewCell.self, forCellReuseIdentifier: "OvaDuoProductViewCell")
        return tableView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#0957F9")
        return bgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        addSubview(tableView)
        bgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200.pix())
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-65)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OvaDuoView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.modelArray?[section]
        let type = model?.provide ?? ""
        switch type {
        case "seboie":
            return 0
            
        case "skept":
            return model?.phalar?.count ?? 0
            
        case "olivress":
            return 1
            
        case "tinacosity":
            return model?.phalar?.count ?? 0
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.modelArray?[indexPath.section]
        let type = model?.provide ?? ""
        
        switch type {
        case "seboie":
            return UITableViewCell()
            
        case "skept":
            let cell = tableView.dequeueReusableCell(withIdentifier: "OvaDuoCardViewCell", for: indexPath) as! OvaDuoCardViewCell
            cell.model = model?.phalar?[indexPath.row]
            return cell
            
        case "olivress":
            let cell = tableView.dequeueReusableCell(withIdentifier: "OvaDuoBannerViewCell", for: indexPath) as! OvaDuoBannerViewCell
            return cell
            
        case "tinacosity":
            let cell = tableView.dequeueReusableCell(withIdentifier: "OvaDuoProductViewCell", for: indexPath) as! OvaDuoProductViewCell
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
}
