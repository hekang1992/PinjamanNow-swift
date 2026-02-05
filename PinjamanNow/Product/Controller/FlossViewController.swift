//
//  FlossViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit
import TYAlertController
import BRPickerView

class FlossViewController: BaseViewController {
    
    var orderID: String = ""
    
    var productID: String = ""
    
    var pageTitle: String = ""
    
    var modelArray: [fragthoughiceModel] = []
    
    private let viewModel = AppViewModel()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setTitleColor(.white, for: .normal)
        sureBtn.setTitle(languageCode == .indonesian ? "Berikutnya" : "Next", for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        sureBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        return sureBtn
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == .indonesian ? UIImage(named: "flo_id_head_image") : UIImage(named: "flo_en_head_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.layer.cornerRadius = 14
        whiteView.layer.masksToBounds = true
        whiteView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        whiteView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return whiteView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = ""
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.text = ""
        descLabel.textColor = UIColor.init(hexString: "#333333")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return descLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 88
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OvaltineViewCell.self, forCellReuseIdentifier: "OvaltineViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#0956FB")
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(295.pix())
        }
        
        view.addSubview(appHeadView)
        appHeadView.nameLabel.text = pageTitle
        appHeadView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        appHeadView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toProductVc()
        }
        
        view.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 315.pix(), height: 55.pix()))
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appHeadView.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 345.pix(), height: 240.pix()))
        }
        
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom)
            make.left.right.equalToSuperview().inset(15.pix())
            make.bottom.equalTo(sureBtn.snp.top).offset(-10.pix())
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView).offset(126)
            make.left.right.bottom.equalTo(whiteView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.basicInfo()
        }
    }
    
}

extension FlossViewController {
    
    private func basicInfo() async {
        do {
            let paras = ["institutionit": productID]
            let model = try await viewModel.flossInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                self.modelArray = model.record?.libr?.argentfication ?? []
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    private func saveInfo(with paras: [String: String]) async {
        do {
            let model = try await viewModel.saveFlossInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                Task {
                    await self.productMessageInfo(with: productID,
                                                  orderID: orderID,
                                                  viewModel: viewModel)
                }
            }else {
                ToastManager.showMessage(model.calcfootment ?? "")
            }
        } catch {
            
        }
    }
    
    @objc func sureBtnClick() {
        var paras = ["institutionit": productID]
        for model in modelArray {
            let key = model.bebit ?? ""
            let value = model.provide ?? ""
            paras[key] = value
        }
        Task {
            await self.saveInfo(with: paras)
        }
        
    }
}

extension FlossViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OvaltineViewCell", for: indexPath) as! OvaltineViewCell
        return cell
    }
    
}

extension FlossViewController {
    
    private func tapCellWithType(cell: OvaltineViewCell, listModel: fragthoughiceModel) {
        let popView = PopAuthListView(frame: self.view.bounds)
        popView.nameLabel.text = listModel.actionsome ?? ""
        let modelArray = listModel.cineial ?? []
        
        let text = cell.enterFiled.text ?? ""
        for (index, model) in modelArray.enumerated() {
            let targetText = model.sy ?? ""
            if text == targetText {
                popView.selectedIndex = index
            }
        }
        
        popView.modelArray = modelArray
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        
        popView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        popView.sureBlock = { [weak self] model in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                listModel.executiveitious = model.sy ?? ""
                listModel.provide = model.provide ?? ""
                cell.enterFiled.text = model.sy ?? ""
            }
        }
        
        self.present(alertVc!, animated: true)
    }
    
}
