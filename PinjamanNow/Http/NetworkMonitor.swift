//
//  NetworkMonitor.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/7.
//

import Alamofire

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    enum Status {
        case unknown
        case notReachable
        case wifi
        case cellular
    }
    
    var statusChanged: ((Status) -> Void)?
    
    private let manager: NetworkReachabilityManager?
    private var isMonitoring = false
    
    private init() {
        self.manager = NetworkReachabilityManager()
    }
    
    var currentStatus: Status {
        guard let manager = manager else { return .unknown }
        
        switch manager.status {
        case .notReachable:
            return .notReachable
        case .reachable(.ethernetOrWiFi):
            return .wifi
        case .reachable(.cellular):
            return .cellular
        case .unknown:
            return .unknown
        }
    }
    
    var isConnected: Bool {
        return manager?.isReachable ?? false
    }
    
    func start() {
        guard !isMonitoring, let manager = manager else { return }
        
        isMonitoring = true
        
        manager.startListening { [weak self] status in
            guard let self = self else { return }
            
            let networkStatus: Status
            switch status {
            case .notReachable:
                networkStatus = .notReachable
            case .reachable(.ethernetOrWiFi):
                networkStatus = .wifi
            case .reachable(.cellular):
                networkStatus = .cellular
            case .unknown:
                networkStatus = .unknown
            }
            
            self.statusChanged?(networkStatus)
        }
    }
    
    func stop() {
        guard isMonitoring, let manager = manager else { return }
        
        manager.stopListening()
        isMonitoring = false
    }
    
    deinit {
        stop()
    }
}
