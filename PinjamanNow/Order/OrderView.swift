//
//  OrderView.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/4.
//

import UIKit
import SnapKit

enum OrderTabType: Int {
    case all = 0
    case inProgress
    case repayment
    case finished
    
    var requestType: String {
        switch self {
        case .all:        return "4"
        case .inProgress: return "7"
        case .repayment:  return "6"
        case .finished:   return "5"
        }
    }
}

class OrderView: UIView {
    
    var listModelArray: [argentficationModel]? {
        didSet {
            let isEmpty = listModelArray?.isEmpty ?? true
            emptyView.isHidden = !isEmpty
            tableView.isHidden = isEmpty
        }
    }
    
    var clickblock: ((OrderTabType) -> Void)?
    
    var cellblock: ((argentficationModel) -> Void)?
    
    var addAction: (() -> Void)?
    
    let languageCode = LanguageManager.current
    
    private var selectedButton: UIButton?
    
    lazy var headImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "od_head_list_image")
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = languageCode == .indonesian ? "Pesanan" : "Bills"
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    lazy var bgView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 12
        v.backgroundColor = UIColor(hexString: "#FFFFFF")
        return v
    }()
    
    lazy var oneBtn = makeButton(title: languageCode == .indonesian ? "Semua" : "All")
    lazy var twoBtn = makeButton(title: languageCode == .indonesian ? "Dalam proses" : "In progress")
    lazy var threeBtn = makeButton(title: languageCode == .indonesian ? "Belum lunas" : "Repayment")
    lazy var fourBtn = makeButton(title: languageCode == .indonesian ? "Lunas" : "Finished")
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .center
        return sv
    }()
    
    lazy var indicatorImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "oc_j_ty_image")
        return iv
    }()
    
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
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        tableView.isHidden = true
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
    
    private var indicatorCenterXConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headImageView)
        addSubview(nameLabel)
        addSubview(bgView)
        addSubview(tableView)
        addSubview(emptyView)
        
        bgView.addSubview(stackView)
        bgView.addSubview(indicatorImageView)
        
        setupButtons()
        layoutUI()
        
        updateSelectedButton(oneBtn, animated: false)
        clickblock?(.all)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OrderView {
    
    func setupButtons() {
        let normalColor = UIColor(hexString: "#B4B4B4")
        
        oneBtn.tag = OrderTabType.all.rawValue
        twoBtn.tag = OrderTabType.inProgress.rawValue
        threeBtn.tag = OrderTabType.repayment.rawValue
        fourBtn.tag = OrderTabType.finished.rawValue
        
        [oneBtn, twoBtn, threeBtn, fourBtn].forEach {
            stackView.addArrangedSubview($0)
            $0.setTitleColor(normalColor, for: .normal)
            $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
}

private extension OrderView {
    
    func layoutUI() {
        headImageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(193.pix())
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(54)
            $0.left.equalToSuperview().offset(20)
        }
        
        bgView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 335.pix(), height: 60.pix()))
        }
        
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(15.pix())
            $0.top.equalToSuperview().offset(20)
            $0.height.equalTo(20)
        }
        
        indicatorImageView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(2)
            $0.size.equalTo(CGSize(width: 20, height: 6))
            indicatorCenterXConstraint = $0.centerX.equalTo(oneBtn.snp.centerX).constraint
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bgView.snp.bottom).offset(8.pix())
        }
        
        emptyView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bgView.snp.bottom).offset(8.pix())
        }
        
        emptyView.addAction = { [weak self] in
            self?.addAction?()
        }
    }
    
    func makeButton(title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return btn
    }
}

private extension OrderView {
    
    @objc func buttonTapped(_ sender: UIButton) {
        updateSelectedButton(sender, animated: true)
        
        if let type = OrderTabType(rawValue: sender.tag) {
            clickblock?(type)
        }
    }
    
    func updateSelectedButton(_ button: UIButton, animated: Bool) {
        let normalColor = UIColor(hexString: "#B4B4B4")
        let selectedColor = UIColor(hexString: "#0956FB")
        
        [oneBtn, twoBtn, threeBtn, fourBtn].forEach {
            $0.setTitleColor(normalColor, for: .normal)
        }
        
        button.setTitleColor(selectedColor, for: .normal)
        selectedButton = button
        
        indicatorCenterXConstraint?.deactivate()
        indicatorImageView.snp.makeConstraints {
            indicatorCenterXConstraint = $0.centerX.equalTo(button.snp.centerX).constraint
        }
        
        if animated {
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.6,
                options: .curveEaseInOut
            ) {
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
        }
    }
}

extension OrderView: UITableViewDelegate, UITableViewDataSource {
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
            self.cellblock?(model)
        }
    }
    
}
