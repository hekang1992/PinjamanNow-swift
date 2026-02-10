//
//  CardViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit
import TYAlertController

class CardViewController: BaseViewController {
    
    var orderID: String = ""
    
    var productID: String = ""
    
    var pageTitle: String = ""
    
    private var camera: SystemCamera?
    
    private let viewModel = AppViewModel()
    
    private let locationService = LocationService()
    
    private var one: String = ""
    private var two: String = ""
    
//    lazy var headImageView: UIImageView = {
//        let headImageView = UIImageView()
//        headImageView.image = UIImage(named: "product_li_bg_image")
//        return headImageView
//    }()
    
    lazy var headImageView: UIView = {
        let bgView = UIView()
//        bgView.layer.cornerRadius = 16
//        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#0956FB")
        return bgView
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setTitleColor(.white, for: .normal)
        sureBtn.setTitle(languageCode == .indonesian ? "Berikutnya" : "Next", for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        sureBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        return sureBtn
    }()
    
    lazy var listView: CardListView = {
        let listView = CardListView(frame: .zero)
        return listView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(298.pix())
        }
        
        view.addSubview(appHeadView)
        appHeadView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        appHeadView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toProductVc()
        }
        
        view.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 315.pix(), height: 55.pix()))
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.configTitle(with: pageTitle)
        
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.top.equalTo(appHeadView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(sureBtn.snp.top).offset(-5.pix())
        }
        
        listView.tapClickBlock = { [weak self] in
            guard let self = self else { return }
            camera = SystemCamera(
                from: self,
                cameraPosition: .rear
            ) { [weak self] imageData in
                self?.camera = nil
            }
            camera?.present()
        }
        
        locationService.success = { result in
            print("result====\(result)")
        }
        
        locationService.start()
        
        one = String(Int(Date().timeIntervalSince1970))
        
    }
    
}

extension CardViewController {
    
    func configTitle(with title: String) {
        appHeadView.nameLabel.text = title
    }
    
    @objc func sureBtnClick() {
        camera = SystemCamera(
            from: self,
            cameraPosition: .rear
        ) { [weak self] imageData in
            Task {
                await self?.uploadImageInfo(with: imageData)
            }
            self?.camera = nil
        }
        camera?.present()
    }
    
    private func uploadImageInfo(with imageData: Data) async {
        do {
            let paras = ["provide": "11",
                         "xanthoptionical": "2",
                         "centuryious": "",
                         "extroise": "1",
                         "rhombless": LoginManager.shared.getPhone()]
            let model = try await viewModel.uploadInfo(with: paras,imageData: imageData)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                popCardMessageView(with: model)
            }else {
                ToastManager.showMessage(model.calcfootment ?? "")
            }
        } catch {
            
        }
    }
    
    private func popCardMessageView(with model: BaseModel) {
        let popView = PopCardMessageView(frame: self.view.bounds)
        popView.model = model
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        popView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        popView.sureBlock = { [weak self] in
            Task {
                await self?.dsaNameInfo(with: popView)
            }
        }
    }
    
    private func dsaNameInfo(with listView: PopCardMessageView) async {
        two = String(Int(Date().timeIntervalSince1970))
        do {
            let paras = ["killature": listView.threeView.enterFiled.text ?? "",
                         "pylacity": listView.twoView.enterFiled.text ?? "",
                         "sy": listView.oneView.enterFiled.text ?? "",
                         "selfopen": LoginManager.shared.getPhone(),
                         "orderible": orderID,
                         "institutionit": productID]
            let model = try await viewModel.saveCardInfo(with: paras)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                self.dismiss(animated: true)
                self.listView.bImageView.image = UIImage(named: "sel_a_ca_image")
                Task {
                    try? await Task.sleep(nanoseconds: 250_000_000)
                    let faceVc = FacialViewController()
                    faceVc.productID = productID
                    faceVc.orderID = orderID
                    faceVc.pageTitle = pageTitle
                    self.navigationController?.pushViewController(faceVc, animated: true)
                }
                Task {
                    try? await Task.sleep(nanoseconds: 3_000_000_000)
                    await self.uploadStdInfo()
                }
            }else {
                ToastManager.showMessage(model.calcfootment ?? "")
            }
        } catch {
            
        }
    }
    
}


extension CardViewController {
    
    private func uploadStdInfo() async {
        do {
            let paras = ["manu": productID,
                         "anemion": "2",
                         "canproof": orderID,
                         "armaneity": IDFVKeychainManager.shared.getIDFV(),
                         "vagaster": IDFVKeychainManager.shared.getIDFA(),
                         "fidel": UserDefaults.standard.object(forKey: "longitude") as? String ?? "",
                         "regionlet": UserDefaults.standard.object(forKey: "latitude") as? String ?? "",
                         "recentlyfaction": one,
                         "dogmatization": two]
            let _ = try await viewModel.uploadStudyInfo(with: paras)
        } catch {
            
        }
    }
    
}
