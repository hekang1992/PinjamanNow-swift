//
//  CenterViewController.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/3.
//

import UIKit
import SnapKit
import MJRefresh

class CenterViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    lazy var centerView: ProfileView = {
        let centerView = ProfileView()
        return centerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        centerView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.getCenterInfo()
            }
        })
        
        centerView.cellBlock = { [weak self] model in
            guard let self = self else { return }
            let pageUrl = model.joinency ?? ""
            
            switch true {
            case pageUrl.contains(scheme_url):
                DeepLinkProcessor.handleString(pageUrl, from: self)
                
            case pageUrl.contains("http"):
                self.goH5WebVcWith(to: pageUrl)
                
            default:
                break
            }
        }
        
        centerView.tapClickBlock = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case "1":
//                let ocList = OrderListViewController()
//                ocList.type = "4"
//                ocList.pageTitle = languageCode == .indonesian ? "Semua" : "All"
//                self.navigationController?.pushViewController(ocList, animated: true)
                NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil, userInfo: ["tabBar": "1", "type": "4"])
                
            case "2":
//                let ocList = OrderListViewController()
//                ocList.type = "7"
//                ocList.pageTitle = languageCode == .indonesian ? "Dalam proses" : "In progress"
//                self.navigationController?.pushViewController(ocList, animated: true)
                NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil, userInfo: ["tabBar": "1", "type": "7"])
                
            case "3":
//                let ocList = OrderListViewController()
//                ocList.type = "6"
//                ocList.pageTitle = languageCode == .indonesian ? "Belum lunas" : "Repayment"
//                self.navigationController?.pushViewController(ocList, animated: true)
                NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil, userInfo: ["tabBar": "1", "type": "6"])
                
            case "4":
//                let ocList = OrderListViewController()
//                ocList.type = "5"
//                ocList.pageTitle = languageCode == .indonesian ? "Lunas" : "Finished"
//                self.navigationController?.pushViewController(ocList, animated: true)
                NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil, userInfo: ["tabBar": "1", "type": "5"])
                
            default:
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.getCenterInfo()
        }
    }
    
}

extension CenterViewController {
    
    private func getCenterInfo() async {
        do {
            let paras = ["pecunular": "1"]
            let model = try await viewModel.centerInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                self.centerView.listArray = model.record?.entersome ?? []
                self.centerView.tableView.reloadData()
            }
            await MainActor.run {
                self.centerView.tableView.mj_header?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                self.centerView.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
}
