//
//  FacialViewController.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit
import TYAlertController

class FacialViewController: BaseViewController {
    
    var orderID: String = ""
    
    var productID: String = ""
    
    var pageTitle: String = ""
    
    private var camera: SystemCamera?
    
    private let viewModel = AppViewModel()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "product_li_bg_image")
        return headImageView
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
        listView.bgImageView.image = languageCode == .indonesian ? UIImage(named: "fa_desc_id_imci") : UIImage(named: "fa_desc_a_imci")
        listView.nameLabel.text = languageCode == .indonesian ? "Foto depan" : "Face"
        listView.aImageView.image = UIImage(named: "cafa_bg_a_image")
        listView.cImageView.image = languageCode == .indonesian ? UIImage(named: "id_st_fasq_image") : UIImage(named: "en_st_fasq_image")
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
        
    }
    
}

extension FacialViewController {
    
    func configTitle(with title: String) {
        appHeadView.nameLabel.text = title
    }
    
    @objc func sureBtnClick() {
        camera = SystemCamera(
            from: self,
            cameraPosition: .front
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
            let paras = ["provide": "10",
                         "xanthoptionical": "2",
                         "centuryious": "",
                         "extroise": "1",
                         "rhombless": LoginManager.shared.getPhone()]
            let model = try await viewModel.uploadInfo(with: paras,imageData: imageData)
            let bebit = model.bebit ?? ""
            if bebit == "0" || bebit == "00" {
                self.listView.bImageView.image = UIImage(named: "sel_a_ca_image")
                Task {
                    try? await Task.sleep(nanoseconds: 250_000_000)
                    await self.productMessageInfo(with: productID,
                                                  orderID: orderID,
                                                  viewModel: viewModel)
                }
            }else {
                ToastManager.showMessage(model.calcfootment ?? "")
            }
        } catch {
            
        }
    }
    
}
