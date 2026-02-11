//
//  CustomTabBar.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/3.
//

import UIKit
import SnapKit
import CoreLocation

protocol CustomTabBarDelegate: AnyObject {
    func didSelectTab(at index: Int)
}

class CustomTabBar: UIView {
    
    weak var delegate: CustomTabBarDelegate?
    
    private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0
    
    private let tabImages = [
        ("tab_home_ic_01", "tab_home_ic"),
        ("tab_order_ic_01", "tab_order_ic"),
        ("tab_me_ic_01", "tab_me_ic")
    ]
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundImageView.image = UIImage(named: "tab_bg")
        addSubview(backgroundImageView)
        addSubview(containerView)
        
        createTabButtons()
        setupSnapKitConstraints()
        updateButtonStates()
    }
    
    private func createTabButtons() {
        for (index, (normalImage, selectedImage)) in tabImages.enumerated() {
            let button = UIButton(type: .custom)
            button.tag = index
            button.setImage(UIImage(named: normalImage), for: .normal)
            button.setImage(UIImage(named: selectedImage), for: .selected)
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            button.imageView?.contentMode = .scaleAspectFit
            button.adjustsImageWhenHighlighted = false
            
            containerView.addSubview(button)
            buttons.append(button)
        }
    }
    
    private func setupSnapKitConstraints() {
        self.snp.makeConstraints { make in
            make.width.equalTo(335.pix())
            make.height.equalTo(62.pix())
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        layoutButtonsUsingStackView()
    }
    
    
    private func layoutButtonsUsingStackView() {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        
        containerView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        buttons.forEach { button in
            button.snp.makeConstraints { make in
                make.width.height.equalTo(32.pix())
            }
        }
    }
    
    @objc private func tabButtonTapped(_ sender: UIButton) {
        
        let status = CLLocationManager().authorizationStatus
        if LanguageManager.current == .indonesian {
            if status == .restricted || status == .denied {
                self.showAuthAlert()
                return
            }
        }
        
        let index = sender.tag
        
        guard selectedIndex != index else { return }
        
        selectedIndex = index
        updateButtonStates()
        
        delegate?.didSelectTab(at: index)
    }
    
    private func updateButtonStates() {
        for (index, button) in buttons.enumerated() {
            button.isSelected = (index == selectedIndex)
        }
    }
    
    func setSelectedTab(at index: Int) {
        guard index >= 0 && index < buttons.count else { return }
        selectedIndex = index
        updateButtonStates()
    }
}

extension CustomTabBar {
    
    func showAuthAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: LanguageManager.current == .indonesian ? "Izin Lokasi" : "Location Permission",
                message: LanguageManager.current == .indonesian ? "Izin lokasi adalah persyaratan wajib untuk verifikasi identitas. Izin ini hanya digunakan untuk verifikasi kali ini, dan proses tidak dapat dilanjutkan jika tidak diaktifkan. Silakan pergi ke Pengaturan untuk memberikan otorisasi." : "Location permission is a necessary requirement for identity verification. It is only used for this verification, and the process cannot continue if it is not enabled. Please go to Settings to authorize it.",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: LanguageManager.current == .indonesian ? "Batalkan" : "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: LanguageManager.current == .indonesian ? "Masuk ke Pengaturan" : "Go to Settings", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let keyWindow = windowScene.windows.first(where: \.isKeyWindow) else {
                return
            }
            keyWindow.rootViewController?.present(alert, animated: true)
            
        }
    }
}
