//
//  ViewModel.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import Foundation

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

// MARK: - home_page
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
    
    func citysInfo() async throws -> BaseModel {
        
        return try await NetworkManager.shared.getRequest(
            url: "/nameling/prima"
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
    
    func uploadLoacationInfo(with parameters: [String: Any]) async throws -> BaseModel {
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/large",
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
    
    func uploadLoginInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/sorc",
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

// MARK: - product_page
extension AppViewModel {
    
    func productDetailInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/signfold",
            parameters: parameters
        )
    }
    
    func applyOrderInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/provide",
            parameters: parameters
        )
    }
    
}

// MARK: - card_image_page
extension AppViewModel {
    
    func cardInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.getRequest(
            url: "/nameling/music",
            parameters: parameters
        )
    }
    
    func saveCardInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/meria",
            parameters: parameters
        )
    }
    
    func uploadInfo(with parameters: [String: String], imageData: Data) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.uploadImage(
            url: "/nameling/airdom",
            imageData: imageData,
            parameters: parameters
        )
    }
    
}

// MARK: - basic_page
extension AppViewModel {
    
    func basicInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/emeseriesth",
            parameters: parameters
        )
    }
    
    func saveBasicInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/dictaceous",
            parameters: parameters
        )
    }
    
}

// MARK: - floss_page
extension AppViewModel {
    
    func flossInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/spring",
            parameters: parameters
        )
    }
    
    func saveFlossInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/ponder",
            parameters: parameters
        )
    }
    
    func uploadFlossInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/directoro",
            parameters: parameters
        )
    }
    
}

// MARK: - basic_page
extension AppViewModel {
    
    func walletInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/joinency",
            parameters: parameters
        )
    }
    
    func saveWalletInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        await MainActor.run {
            LoadingManager.shared.show()
        }
        
        defer {
            Task { @MainActor in
                LoadingManager.shared.hide()
            }
        }
        
        return try await NetworkManager.shared.postRequest(
            url: "/nameling/argentfication",
            parameters: parameters
        )
    }
    
}
