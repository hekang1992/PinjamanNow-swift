//
//  LoadingManager.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/3.
//

import UIKit
import SnapKit

class LoadingManager {
    static let shared = LoadingManager()
    
    private var loadingView: UIView?
    private var activityIndicator: UIActivityIndicatorView?
    
    private init() {}
    
    func show() {
        hide()
        
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
                return
            }
            
            let maskView = UIView()
            maskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            maskView.isUserInteractionEnabled = true
            
            let whiteView = UIView()
            whiteView.backgroundColor = .white
            whiteView.layer.cornerRadius = 12
            whiteView.layer.shadowColor = UIColor.black.cgColor
            whiteView.layer.shadowOffset = CGSize(width: 0, height: 2)
            whiteView.layer.shadowOpacity = 0.2
            whiteView.layer.shadowRadius = 8
            
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .darkGray
            indicator.startAnimating()
            
            whiteView.addSubview(indicator)
            maskView.addSubview(whiteView)
            window.addSubview(maskView)
            
            maskView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            whiteView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.height.equalTo(100)
            }
            
            indicator.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            self.loadingView = maskView
            self.activityIndicator = indicator
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
            self.activityIndicator = nil
        }
    }
    
}
