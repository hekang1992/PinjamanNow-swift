//
//  OrderViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit
import MJRefresh

class OrderViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    var orderType: OrderTabType = .all
    
    lazy var orderView: OrderView = {
        OrderView(frame: .zero)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindOrderView()
        
        self.orderView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.refreshOrderList()
        })
        
        self.orderView.addAction = {
            NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil)
        }
        
        self.orderView.cellblock = { [weak self] model in
            guard let self = self else { return }
            let pageUrl = model.hear ?? ""
            
            switch true {
            case pageUrl.contains(scheme_url):
                DeepLinkProcessor.handleString(pageUrl, from: self)
                
            case pageUrl.contains("http"):
                self.goH5WebVcWith(to: pageUrl)
                
            default:
                break
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshOrderList()
    }
}

private extension OrderViewController {
    
    func setupUI() {
        view.addSubview(orderView)
        orderView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-70)
        }
    }
    
    func bindOrderView() {
        orderView.clickblock = { [weak self] type in
            guard let self else { return }
            self.orderType = type
            self.refreshOrderList()
        }
    }
}

private extension OrderViewController {
    
    func refreshOrderList() {
        Task {
            await fetchOrderList()
        }
    }
    
    func fetchOrderList() async {
        do {
            let params: [String: String] = [
                "majorics": orderType.requestType,
                "electionness": "1",
                "managerably": "60"
            ]
            
            let model = try await viewModel.orderListInfo(with: params)
            
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                let modelArray = model.record?.argentfication ?? []
                self.orderView.listModelArray = modelArray
                self.orderView.tableView.reloadData()
            }
            await MainActor.run {
                self.orderView.tableView.mj_header?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                self.orderView.tableView.mj_header?.endRefreshing()
            }
        }
    }
}
