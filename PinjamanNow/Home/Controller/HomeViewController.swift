//
//  HomeViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit
import MJRefresh

let cyania = "1000"
let himfold = "1001"
class HomeViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    lazy var homeView: HomeView = {
        let homeView = HomeView(frame: .zero)
        homeView.isHidden = true
        return homeView
    }()
    
    lazy var duoView: OvaDuoView = {
        let duoView = OvaDuoView(frame: .zero)
        duoView.isHidden = true
        return duoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(duoView)
        duoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        homeView.clickBlock = { [weak self] model in
            guard let self = self else { return }
            if homeView.applyView.sureBtn.isSelected == false {
                ToastManager.showMessage("Please read and agreed to the Loan terms")
                return
            }
            Task {
                let productID = model.personal ?? ""
                await self.clickProductInfo(to: productID)
            }
        }
        
        homeView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.getHomeInfo()
            }
        })
        
        duoView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.getHomeInfo()
            }
        })
        
        Task {
            await self.allCitysInfo()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.getHomeInfo()
        }
    }
    
}

extension HomeViewController {
    
    private func getHomeInfo() async {
        do {
            let model = try await viewModel.homeInfo()
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                let productArray = model.record?.argentfication ?? []
                
                let hasSkept = productArray.contains { model in
                    (model.provide ?? "") == "skept"
                }
                
                if hasSkept {
                    self.homeView.isHidden = true
                    self.duoView.isHidden = false
                    self.duoView.modelArray = productArray
                } else {
                    let listModel = productArray.first(where: { $0.provide == "habitot" })
                    self.homeView.isHidden = false
                    self.duoView.isHidden = true
                    self.homeView.model = listModel?.phalar?.first
                }
                
            }
            await MainActor.run {
                self.homeView.scrollView.mj_header?.endRefreshing()
                self.duoView.tableView.mj_header?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                self.homeView.scrollView.mj_header?.endRefreshing()
                self.duoView.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func clickProductInfo(to productID: String) async {
        do {
            let paras = ["himfold": himfold,
                         "cyania": cyania,
                         "dactyl": cyania,
                         "institutionit": productID]
            let model = try await viewModel.clickProductInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                let pageUrl = model.record?.graphen ?? ""
                
                switch true {
                case pageUrl.contains(scheme_url):
                    DeepLinkProcessor.handleString(pageUrl, from: self)
                    
                case pageUrl.contains("http"):
                    self.goH5WebVcWith(to: pageUrl)
                    
                default:
                    break
                }
            }
        } catch {
            
        }
    }
    
}

extension HomeViewController {
    
    private func allCitysInfo() async {
        do {
            let model = try await viewModel.citysInfo()
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                CitysManager.shared.citysModel = model.record?.argentfication ?? []
            }
        } catch {
            
        }
    }
    
}

