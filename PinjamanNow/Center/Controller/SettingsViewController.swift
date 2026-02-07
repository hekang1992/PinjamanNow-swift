//
//  SettingsViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/4.
//

import UIKit
import SnapKit
import TYAlertController

class SettingsViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "mic_list_image")
        bgImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBgImageTap))
        bgImageView.addGestureRecognizer(tapGesture)
        
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "exit_ic_image")
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = languageCode == .indonesian ? "Keluar" : "Log out"
        nameLabel.textColor = UIColor.init(hexString: "#010204")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return nameLabel
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "right_li_a_image")
        return rightImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        view.addSubview(appHeadView)
        appHeadView.nameLabel.text = languageCode == .indonesian ? "Pengaturan" : "Set up"
        appHeadView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        appHeadView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#0956FB")
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(appHeadView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        let lImageView = UIImageView()
        lImageView.image = UIImage(named: "login_bg_logo")
        
        bgView.addSubview(lImageView)
        lImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(36)
            make.width.height.equalTo(80)
        }
        
        let oneLabel = UILabel()
        oneLabel.textAlignment = .center
        oneLabel.text = "Pinjaman Now"
        oneLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        oneLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        let versionLabel = UILabel()
        versionLabel.textAlignment = .center
        versionLabel.text = "Version:1.0.0"
        versionLabel.textColor = UIColor.init(hexString: "#C1EBFF")
        versionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        bgView.addSubview(oneLabel)
        bgView.addSubview(versionLabel)
        
        oneLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(19)
            make.top.equalTo(lImageView.snp.bottom).offset(20)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(14)
            make.top.equalTo(oneLabel.snp.bottom).offset(12)
        }
        
        view.addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(rightImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 335.pix(), height: 48.pix()))
            make.centerX.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(22)
            make.left.equalToSuperview().offset(15)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 12, height: 15))
            make.right.equalToSuperview().offset(-16)
        }
        
        let deleteBtn = UIButton(type: .custom)
        deleteBtn.isHidden = languageCode == .indonesian ? true : false
        deleteBtn.setImage(UIImage(named: "del_ac_image"), for: .normal)
        deleteBtn.adjustsImageWhenHighlighted = false
        view.addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.size.equalTo(CGSize(width: 305, height: 80))
        }
        deleteBtn.addTarget(self, action: #selector(deleBtnClick), for: .touchUpInside)
    }

}

extension SettingsViewController {
    
    @objc private func handleBgImageTap() {
        let exitView = AppExitView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: exitView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        exitView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        exitView.sureBlock = { [weak self] in
            guard let self = self else { return }
            Task {
                await self.exitInfo()
            }
        }
    }
    
    @objc func deleBtnClick() {
        let exitView = AppCancelView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: exitView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        exitView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        exitView.sureBlock = { [weak self] in
            guard let self = self else { return }
            if exitView.sureBtn.isSelected == false {
                ToastManager.showMessage("Please read and agree to the above")
                return
            }
            Task {
                await self.cancelInfo()
            }
        }
    }
}

extension SettingsViewController {
    
    private func exitInfo() async {
        do {
            let paras = ["ommesque": LoginManager.shared.getPhone()]
            let model = try await viewModel.logoutInfo(with: paras)
            let bebit = model.bebit ?? ""
            ToastManager.showMessage(model.calcfootment ?? "")
            if bebit == "0" || bebit == "00" {
                self.dismiss(animated: true) {
                    LoginManager.shared.clearAll()
                    Task {
                        try? await Task.sleep(nanoseconds: 500_000_000)
                        NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil)
                    }
                }
            }
        } catch {
            
        }
    }
    
    private func cancelInfo() async {
        do {
            let paras = ["ommesque": LoginManager.shared.getPhone()]
            let model = try await viewModel.deleteInfo(with: paras)
            let bebit = model.bebit ?? ""
            ToastManager.showMessage(model.calcfootment ?? "")
            if bebit == "0" || bebit == "00" {
                self.dismiss(animated: true) {
                    LoginManager.shared.clearAll()
                    Task {
                        try? await Task.sleep(nanoseconds: 500_000_000)
                        NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil)
                    }
                }
            }
        } catch {
            
        }
    }
    
}
