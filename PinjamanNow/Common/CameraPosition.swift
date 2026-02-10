//
//  CameraPosition.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import AVFoundation

enum CameraPosition {
    case front
    case rear
}

final class SystemCamera: NSObject {
    
    private weak var fromVC: UIViewController?
    private let cameraPosition: CameraPosition
    private let completion: (Data) -> Void
    
    private lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = false
        picker.cameraDevice = cameraPosition == .front ? .front : .rear
        return picker
    }()
    
    // MARK: - Init
    init(
        from viewController: UIViewController,
        cameraPosition: CameraPosition = .rear,
        completion: @escaping (Data) -> Void
    ) {
        self.fromVC = viewController
        self.cameraPosition = cameraPosition
        self.completion = completion
        super.init()
    }
    
    func present() {
        checkCameraPermission { [weak self] granted in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if granted {
                    self.fromVC?.present(self.picker, animated: true)
                } else {
                    self.showPermissionAlert()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                if self.cameraPosition == .front {
                    self.hidePickerView(pickerView: self.picker.view)
                }
            }
            
        }
    }
    
    private func checkCameraPermission(_ completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            completion(true)
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completion(granted)
            }
            
        default:
            completion(false)
        }
    }
    
    private func showPermissionAlert() {
        guard let vc = fromVC else { return }
        
        let alert = UIAlertController(
            title: "无法使用相机",
            message: "请在系统设置中开启相机权限",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        vc.present(alert, animated: true)
    }
}

extension SystemCamera: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        if let data = compressImage(image, maxKB: 500) {
            completion(data)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

private extension SystemCamera {
    
    func compressImage(_ image: UIImage, maxKB: Int) -> Data? {
        let maxBytes = maxKB * 1024
        var compression: CGFloat = 0.7
        let minCompression: CGFloat = 0.1
        
        guard var data = image.jpegData(compressionQuality: compression) else {
            return nil
        }
        
        while data.count > maxBytes && compression > minCompression {
            compression -= 0.05
            if let newData = image.jpegData(compressionQuality: compression) {
                data = newData
            }
        }
        
        return data
    }
}

extension SystemCamera {
    
    private func hidePickerView(pickerView: UIView) {
        if #available(iOS 26, *) {
            let name = "SwiftUI._UIGraphicsView"
            if let cls = NSClassFromString(name) {
                for view in pickerView.subviews {
                    if view.isKind(of: cls) {
                        if view.bounds.width == 48 && view.bounds.height == 48 {
                            if view.frame.minX > UIScreen.main.bounds.width / 2.0 {
                                view.isHidden = true
                                return
                            }
                        }
                    }
                    hidePickerView(pickerView: view)
                }
            }
        }else {
            let name = "CAMFlipButton"
            for bbview in pickerView.subviews {
                if bbview.description.contains(name) {
                    bbview.isHidden = true
                    return
                }
                hidePickerView(pickerView: bbview)
            }
        }
    }
    
}
