//
//  OrderListViewController.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/7.
//

import UIKit
import SnapKit
import MJRefresh

class OrderListViewController: BaseViewController {
    
    var type: String = "4"
    
    var pageTitle: String = ""
    
    private let viewModel = AppViewModel()
    
    var listModelArray: [argentficationModel]? {
        didSet {
            let isEmpty = listModelArray?.isEmpty ?? true
            emptyView.isHidden = !isEmpty
            tableView.isHidden = isEmpty
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isHidden = true
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var emptyView: AppEmptyView = {
        let emptyView = AppEmptyView()
        emptyView.isHidden = true
        return emptyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        view.addSubview(appHeadView)
        appHeadView.nameLabel.text = pageTitle
        appHeadView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        appHeadView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(appHeadView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(appHeadView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        emptyView.addAction = {
            NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil)
        }
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            refreshOrderList()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshOrderList()
    }
    
}

extension OrderListViewController {
    
    private func refreshOrderList() {
        Task {
            await fetchOrderList()
        }
    }
    
    func fetchOrderList() async {
        do {
            let params: [String: String] = [
                "majorics": type,
                "electionness": "1",
                "managerably": "60"
            ]
            
            let model = try await viewModel.orderListInfo(with: params)
            
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                let modelArray = model.record?.argentfication ?? []
                self.listModelArray = modelArray
                self.tableView.reloadData()
            }
            await MainActor.run {
                self.tableView.mj_header?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                self.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
}

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
        let model = listModelArray?[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = listModelArray?[indexPath.row] {
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
    
}
