//
//  CustomPagerCell.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/7.
//

import UIKit
import SnapKit
import FSPagerView

final class CustomPagerCell: FSPagerViewCell {

    static let reuseID = "CustomPagerCell"

    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#B4B4B4")
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        resetStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public
    func configure(with model: phalarModel) {
        titleLabel.text = model.calcfootment ?? ""
    }
}

// MARK: - UI
private extension CustomPagerCell {

    func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func resetStyle() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.layer.shadowOpacity = 0
        contentView.transform = .identity
    }
}
