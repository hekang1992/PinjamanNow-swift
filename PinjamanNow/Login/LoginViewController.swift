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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginView.phoneFiled.becomeFirstResponder()
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
                self.loginView.codeFiled.becomeFirstResponder()
            }
            ToastManager.showMessage(model.calcfootment ?? "")
        } catch {
            
        }
    }
    
    private func toLoginInfo() async {
        let phone = self.loginView.phoneFiled.text ?? ""
        let code = self.loginView.codeFiled.text ?? ""
        let isAgreed = self.loginView.sureBtn.isSelected
        let isIndonesian = languageCode == .indonesian
        self.loginView.phoneFiled.resignFirstResponder()
        self.loginView.codeFiled.resignFirstResponder()
        if phone.isEmpty {
            let message = isIndonesian ?
            "Silakan masukkan nomor ponsel Anda." :
            "Please enter your mobile number."
            ToastManager.showMessage(message)
            return
        }
        
        if code.isEmpty {
            let message = isIndonesian ?
            "Silakan masukkan kode verifikasi." :
            "Please enter the verification code."
            ToastManager.showMessage(message)
            return
        }
        
        if !isAgreed {
            let message = isIndonesian ?
            "Silakan baca dan konfirmasi perjanjian privasi." :
            "Please read and confirm the privacy agreement."
            ToastManager.showMessage(message)
            return
        }
        
        let paras = ["camera": phone, "ruminade": code, "airdom": "1"]
        
        do {
            let model = try await viewModel.toLoginInfo(with: paras)
            let bebit = model.bebit ?? ""
            
            if let message = model.calcfootment, !message.isEmpty {
                ToastManager.showMessage(message)
            }
            
            if bebit == "0" || bebit == "00" {
                let phone = model.record?.camera ?? ""
                let token = model.record?.salinee ?? ""
                
                LoginManager.shared.saveLoginInfo(phone: phone, token: token)
                
                try? await Task.sleep(nanoseconds: 500_000_000)
                self.changeRootVc()
            }
        } catch {
            
        }
    }
    
}

extension LoginViewController {
    
    private func changeRootVc() {
        NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil)
    }
    
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
            
            UIView.animate(
                withDuration: 0.25,
                delay: 0.25,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.5,
                options: .curveEaseInOut
            ) {
                self.loginView.lineView.snp.updateConstraints { make in
                    make.left.right.equalTo(self.loginView.codeBtn)
                }
                self.loginView.layoutIfNeeded()
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
