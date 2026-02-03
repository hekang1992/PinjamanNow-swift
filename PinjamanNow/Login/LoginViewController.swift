//
//  LoginViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    private var countdownTimer: Timer?
    private var remainingSeconds = 60
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.codeBlock = { [weak self] in
            guard let self = self else { return }
            Task {
                await self.getCodeInfo()
            }
        }
        
        loginView.loginBlock = { [weak self] in
            Task {
                await self?.toLoginInfo()
            }
        }
        
        loginView.bacaBlock = { [weak self] in
            ToastManager.showMessage("协议--------")
        }
    }
    
}

extension LoginViewController {
    
    private func getCodeInfo() async {
        let phone = self.loginView.phoneFiled.text ?? ""
        if phone.isEmpty {
            ToastManager.showMessage(languageCode == .indonesian ? "Silakan masukkan nomor ponsel Anda." : "Please enter your mobile number.")
            return
        }
        
        do {
            let paras = ["tryatory": phone, "agencyacity": "1"]
            let model = try await viewModel.getCodeInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                startCountdown()
            }
            ToastManager.showMessage(model.calcfootment ?? "")
        } catch {
            
        }
    }
    
    private func toLoginInfo() async {
        let phone = self.loginView.phoneFiled.text ?? ""
        if phone.isEmpty {
            ToastManager.showMessage(languageCode == .indonesian ? "Silakan masukkan nomor ponsel Anda." : "Please enter your mobile number.")
            return
        }
        
    }
    
}

extension LoginViewController {
    
    private func startCountdown() {
        
        UIView.animate(
            withDuration: 0.25,
            delay: 0.25,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut
        ) {
            self.loginView.lineView.snp.updateConstraints { make in
                make.left.right.equalTo(self.loginView.codeBtn).inset(22)
            }
            self.loginView.layoutIfNeeded()
        }
        
        
        DispatchQueue.main.async {
            self.stopCountdown()
            self.remainingSeconds = 60
            self.updateCountdownButton()
            self.countdownTimer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(self.updateCountdown),
                userInfo: nil,
                repeats: true
            )
            RunLoop.current.add(self.countdownTimer!, forMode: .common)
        }
    }
    
    @objc private func updateCountdown() {
        remainingSeconds -= 1
        
        if remainingSeconds <= 0 {
            stopCountdown()
            self.loginView.codeBtn.isEnabled = true
            self.loginView.codeBtn.setTitle(languageCode == .indonesian ? "Kirim kode" : "Get code", for: .normal)
            UIView.animate(withDuration: 0.25) {
                self.loginView.lineView.snp.updateConstraints { make in
                    make.left.right.equalTo(self.loginView.codeBtn)
                }
            }
        } else {
            updateCountdownButton()
        }
    }
    
    private func updateCountdownButton() {
        let countdownText = "\(remainingSeconds)s"
        self.loginView.codeBtn.setTitle(countdownText, for: .disabled)
        self.loginView.codeBtn.isEnabled = false
    }
    
    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
    
    func resetCountdown() {
        stopCountdown()
        remainingSeconds = 60
        self.loginView.codeBtn.isEnabled = true
        self.loginView.codeBtn.setTitle(languageCode == .indonesian ? "Kirim kode" : "Get code", for: .normal)
    }
    
    
}
