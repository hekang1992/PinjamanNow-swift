//
//  NetworkManager.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

import Foundation
import Alamofire

enum APIError: Error {
    case invalidURL
    case networkError(String)
    case decodingError
    case uploadError
}

let h5_url = "http://8.215.85.208:6873"
let base_url = "http://8.215.85.208:6873/circumbehind"
let scheme_url = "iridular://crepitan.patieer.oilitious"

class NetworkManager {
    static let shared = NetworkManager()
    
    private let getTimeout: TimeInterval = 30
    private let postTimeout: TimeInterval = 60
    
    private init() {}
    
    func getRequest<T: Decodable>(
        url: String,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        guard let url = createRequestUrl(baseUrl: base_url + url) else {
            throw APIError.invalidURL
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = getTimeout
        
        let session = Session(configuration: configuration)
        
        return try await withCheckedThrowingContinuation { continuation in
            session.request(
                url,
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: APIError.networkError(error.localizedDescription))
                }
            }
        }
    }
    
    func postRequest<T: Decodable>(
        url: String,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        guard let url = createRequestUrl(baseUrl: base_url + url) else {
            throw APIError.invalidURL
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = postTimeout
        
        let session = Session(configuration: configuration)
        
        return try await withCheckedThrowingContinuation { continuation in
            session.upload(
                multipartFormData: { multipart in
                    if let parameters = parameters {
                        parameters.forEach { key, value in
                            multipart.append(
                                Data("\(value)".utf8),
                                withName: key
                            )
                        }
                    }
                },
                to: url,
                method: .post,
                headers: headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: APIError.networkError(error.localizedDescription))
                }
            }
        }
    }
    
    func uploadImage<T: Decodable>(
        url: String,
        image: UIImage,
        imageParameterName: String = "image",
        imageName: String = "upload.jpg",
        parameters: [String: String]? = nil,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        guard let url = createRequestUrl(baseUrl: base_url + url),
              let imageData = image.jpegData(compressionQuality: 0.3) else {
            throw APIError.uploadError
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = postTimeout
        
        let session = Session(configuration: configuration)
        
        return try await withCheckedThrowingContinuation { continuation in
            session.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(
                        imageData,
                        withName: imageParameterName,
                        fileName: imageName,
                        mimeType: "image/jpeg"
                    )
                    
                    if let parameters = parameters {
                        for (key, value) in parameters {
                            if let data = value.data(using: .utf8) {
                                multipartFormData.append(data, withName: key)
                            }
                        }
                    }
                },
                to: url,
                method: .post,
                headers: headers
            )
            .uploadProgress { progress in
                print("上传进度: \(progress.fractionCompleted)")
            }
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: APIError.networkError(error.localizedDescription))
                }
            }
        }
    }
    
}

extension NetworkManager {
    
    func createRequestUrl(baseUrl: String) -> URL? {
        let params = CommonParaManager.toJson()
        
        guard var components = URLComponents(string: baseUrl) else { return nil }
        
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components.url
    }
    
}
