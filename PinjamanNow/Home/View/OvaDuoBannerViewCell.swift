//
//  OvaDuoBannerViewCell.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/6.
//

import UIKit
import SnapKit
import FSPagerView

final class OvaDuoBannerViewCell: UITableViewCell {

    // MARK: - Public
    var tapBlock: ((phalarModel) -> Void)?

    var modelArray: [phalarModel] = [] {
        didSet {
            pagerView.reloadData()
        }
    }

    // MARK: - UI
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var pagerView: FSPagerView = {
        let view = FSPagerView()
        view.dataSource = self
        view.delegate = self
        view.register(CustomPagerCell.self,
                      forCellWithReuseIdentifier: CustomPagerCell.reuseID)
        view.interitemSpacing = 5
        view.transformer = FSPagerViewTransformer(type: .linear)
        view.isInfinite = true
        view.automaticSlidingInterval = 3.0
        view.backgroundColor = .clear
        view.layer.borderWidth = 0
        return view
    }()

    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lid_fa_image")
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pengingat Pemberitahuan"
        label.textColor = UIColor(hexString: "#010204")
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .left
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup
private extension OvaDuoBannerViewCell {

    func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(pagerView)
    }

    func setupConstraints() {
        bgView.snp.makeConstraints {
            $0.top.bottom.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 343.pix(), height: 82.pix()))
        }

        bgImageView.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(15)
            $0.size.equalTo(CGSize(width: 12, height: 15))
        }

        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(bgImageView)
            $0.left.equalTo(bgImageView.snp.right).offset(5)
            $0.height.equalTo(15)
        }

        pagerView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.left.equalToSuperview().offset(13)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - FSPagerViewDataSource & Delegate
extension OvaDuoBannerViewCell: FSPagerViewDataSource, FSPagerViewDelegate {

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        modelArray.count
    }

    func pagerView(_ pagerView: FSPagerView,
                   cellForItemAt index: Int) -> FSPagerViewCell {

        let cell = pagerView.dequeueReusableCell(
            withReuseIdentifier: CustomPagerCell.reuseID,
            at: index
        ) as! CustomPagerCell

        cell.configure(with: modelArray[index])
        return cell
    }

    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        tapBlock?(modelArray[index])
    }
}

