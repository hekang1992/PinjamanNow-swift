//
//  ViewModel.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

class AppViewModel {
    
    func appInfo(with parameters: [String: String]) async throws -> BaseModel {
        do {
            let model: BaseModel = try await NetworkManager.shared.postRequest(url: "/nameling/nonagenine", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
}
