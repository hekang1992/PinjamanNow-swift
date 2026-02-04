//
//  ViewModel.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

// MARK: - init_page
class AppViewModel {
    
    func appInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/nonagenine",
            parameters: parameters
        )
    }
    
}

extension AppViewModel {
    
    func homeInfo() async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.getRequest(
            url: "/nameling/calcfootment"
        )
    }
    
    func clickProductInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/ruminade",
            parameters: parameters
        )
    }
    
}

// MARK: - login_page
extension AppViewModel {
    
    func getCodeInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/tryatory",
            parameters: parameters
        )
    }
    
    func toLoginInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/performanceite",
            parameters: parameters
        )
    }
    
}

// MARK: - order_list_page
extension AppViewModel {
    
    func orderListInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/phalar",
            parameters: parameters
        )
    }
    
}

// MARK: - center_page
extension AppViewModel {
    
    func centerInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.getRequest(
            url: "/nameling/scalenature",
            parameters: parameters
        )
    }
    
    func logoutInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.getRequest(
            url: "/nameling/bebit",
            parameters: parameters
        )
    }
    
    func deleteInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.getRequest(
            url: "/nameling/legis",
            parameters: parameters
        )
    }
    
}
