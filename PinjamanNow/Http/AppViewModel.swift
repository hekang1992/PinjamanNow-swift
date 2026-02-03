//
//  ViewModel.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

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
