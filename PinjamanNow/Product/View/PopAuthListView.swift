//
//  PopAuthListView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit

class PopAuthListView: UIView {
    
    private let languageCode = LanguageManager.current
    
    var cancelBlock: (() -> Void)?
    var sureBlock: ((cineialModel) -> Void)?
    
    var selectedIndex: Int? = nil
    
    var modelArray: [cineialModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedModel: cineialModel? {
        guard let selectedIndex = selectedIndex,
              let models = modelArray,
              selectedIndex < models.count else {
            return nil
        }
        return models[selectedIndex]
    }
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#010204")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return nameLabel
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setBackgroundImage(UIImage(named: "fock_a_c_image"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 14
        bgView.layer.masksToBounds = true
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.setTitle(languageCode == .indonesian ? "Mengonfirmasi" : "Confirm", for: .normal)
        confirmBtn.setTitleColor(.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        confirmBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        confirmBtn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        return confirmBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(cancelBtn)
        bgView.addSubview(confirmBtn)
        bgView.addSubview(tableView)
        bgView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(382.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
            make.height.equalTo(16)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(18.pix())
        }
        confirmBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 315.pix(), height: 55.pix()))
            make.bottom.equalToSuperview().offset(-30.pix())
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(cancelBtn.snp.bottom).offset(8.pix())
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalTo(confirmBtn.snp.top).offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopAuthListView {
    
    @objc private func cancelBtnClick() {
        self.cancelBlock?()
    }
    
    @objc private func confirmBtnClick() {
        guard let selectedModel = selectedModel else {
            ToastManager.showMessage(languageCode == .indonesian ? "Silakan pilih satu" : "Please select one")
            return
        }
        self.sureBlock?(selectedModel)
    }
    
}

extension PopAuthListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let model = self.modelArray?[indexPath.row]
        cell.textLabel?.text = model?.sy ?? ""
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        if indexPath.row == selectedIndex {
            cell.backgroundColor = UIColor(hexString: "#F3F3F3")
            cell.textLabel?.textColor = UIColor(hexString: "#0956FB")
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
        } else {
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = UIColor(hexString: "#010204")
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == selectedIndex {
            selectedIndex = nil
        } else {
            selectedIndex = indexPath.row
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.pix()
    }
}
