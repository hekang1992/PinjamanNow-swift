//
//  LaunchViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit

class LaunchViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.image = UIImage(named: "start_page_bg")
        return bgImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        NetworkMonitor.shared.statusChanged = { status in
            switch status {
            case .wifi:
                Task {
                    await self.appInfo()
                }
                UserDefaults.standard.set("WIFI", forKey: "net_type")
                UserDefaults.standard.synchronize()
                NetworkMonitor.shared.stop()
                
            case .cellular:
                Task {
                    await self.appInfo()
                }
                UserDefaults.standard.set("5G", forKey: "net_type")
                UserDefaults.standard.synchronize()
                NetworkMonitor.shared.stop()
                
            case .notReachable:
                UserDefaults.standard.set("Bad Network", forKey: "net_type")
                UserDefaults.standard.synchronize()

                
            case .unknown:
                UserDefaults.standard.set("Unknown Network", forKey: "net_type")
                UserDefaults.standard.synchronize()
                
            }
        }
        NetworkMonitor.shared.start()
        
    }
    
}

extension LaunchViewController {
    
    private func appInfo() async {
        do {
            let paras = DeviceSecurityHelper.fetchSecurityInfo()
            let model = try await viewModel.appInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                let americanate = model.record?.americanate ?? ""
                saveCode(code: americanate)
//                saveCode(code: "3102")
                changeRootVc()
            }
        } catch  {
            
        }
    }
    
    private func saveCode(code: String) {
        UserDefaults.standard.set(code, forKey: "language_code")
        UserDefaults.standard.synchronize()
    }
    
    private func changeRootVc() {
        NotificationCenter.default.post(name: NSNotification.Name("changeRootViewController"), object: nil)
    }
    
}

class LanguageManager {
    
    enum Language: Int {
        case english = 3102
        case indonesian = 9182
        
        var code: String {
            switch self {
            case .english: return "en"
            case .indonesian: return "id"
            }
        }
    }
    
    static var current: Language {
        get {
            let id = UserDefaults.standard.integer(forKey: "language_code")
            return Language(rawValue: id) ?? .english
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "language_code")
        }
    }
    
    static func getLanguageCode() -> String {
        return current.code
    }
}
