//
//  HomeViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit
import MJRefresh
import FBSDKCoreKit
import CoreLocation

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
    
    private let locationService = LocationService()
    
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
        
        duoView.tapClickBlock = { [weak self] model in
            guard let self = self else { return }
            Task {
                let productID = model.personal ?? ""
                await self.clickProductInfo(to: productID)
            }
        }
        
        duoView.tapBlock = { [weak self] model in
            guard let self = self else { return }
            let pageUrl = model.graphen ?? ""
            
            switch true {
            case pageUrl.contains(scheme_url):
                DeepLinkProcessor.handleString(pageUrl, from: self)
                
            case pageUrl.contains("http"):
                self.goH5WebVcWith(to: pageUrl)
                
            default:
                break
            }
            
        }
        
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    await self.allCitysInfo()
                }
                
                group.addTask {
                    await self.uploadIDFAInfo()
                }
                
                await group.waitForAll()
            }
        }
        
        locationService.success = { result in
            print("result====\(result)")
        }
        
        locationService.start()
        
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
        
        let status = CLLocationManager().authorizationStatus
        
        if languageCode == .indonesian {
            if status == .denied || status == .restricted {
                self.showAuthAlert()
                return
            }
        }
        
        locationService.start()
        
        locationService.success = { [weak self] result in
            guard let self = self else { return }
            Task {
                await self.uploadLocationInfo(to: result)
            }
        }
        
        DeviceInfoCollector.collect { info in

            guard let jsonData = try? JSONSerialization.data(
                withJSONObject: info,
                options: []
            ) else {
                return
            }

            let base64String = jsonData.base64EncodedString()

            Task {
                let paras = ["record": base64String]
                await self.uploadDeviceInfo(to: paras)
            }
            
        }
        
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
    
    private func uploadLocationInfo(to paras: [String: Any]) async {
        do {
            let _ = try await viewModel.uploadLoacationInfo(with: paras)
        } catch {
            
        }
    }
    
    private func uploadDeviceInfo(to paras: [String: Any]) async {
        do {
            let _ = try await viewModel.uploadDeviceInfo(with: paras)
        } catch {
            
        }
    }
    
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
    
    private func uploadIDFAInfo() async {
        do {
            let deviceManager = IDFVKeychainManager.shared
            let paras = ["athlern": deviceManager.getIDFV(),
                         "republicanally": deviceManager.getIDFA()]
            let model = try await viewModel.uploadLoginInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                if let googleModel = model.record?.verbade {
                    googleBookInfo(with: googleModel)
                }
            }
        } catch {
            
        }
    }
    
    private func googleBookInfo(with model: verbadeModel) {
        Settings.shared.displayName = model.cinerorium ?? ""
        Settings.shared.appURLSchemeSuffix = model.sexard ?? ""
        Settings.shared.appID = model.ficitor ?? ""
        Settings.shared.clientToken = model.citizenical ?? ""
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: nil
        )
    }
    
}

extension HomeViewController {
    
    func showAuthAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "定位权限未开启",
                message: "请前往系统设置中开启定位权限",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "取消", style: .cancel))
            alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            })
            self.present(alert, animated: true)
        }
    }
    
}

