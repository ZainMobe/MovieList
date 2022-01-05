//
//  BaseViewModel.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import Foundation

enum ApiErrors: Error {
    case invalidResponse
    case failToParse
    case invalidDowncasting
    case noInternet
}

class BaseViewModel: NSObject {
    
    func callApi<T: Decodable>(targe: NetworkService, onSuccess: @escaping (T) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        ApiNetworkManager.shared.provider.request(targe) { (result) in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                switch statusCode {
                case 200, 201:
                    
                    do {
                        let obj = try JSONDecoder().decode(T.self, from: moyaResponse.data)
                        onSuccess(obj)
                    } catch (let error) {
                        LogsManager.shared.logAPI(type: .error, url: targe.path, response: error)
                        onFailure(error.localizedDescription)
                    }
                default:
                    do {
                        guard let response: [String: Any] = try moyaResponse.mapJSON() as? [String: Any] else {throw ApiErrors.invalidResponse}
                        guard let message = response["message"] as? String else { throw ApiErrors.invalidResponse}
                        LogsManager.shared.logAPI(type: .error, url: targe.path, response: response)
                        onFailure(message)
                    } catch (let error) {
                        LogsManager.shared.logAPI(type: .error, url: targe.path, response: error)
                        onFailure(error.localizedDescription)
                    }
                }
            case let .failure(error):
                LogsManager.shared.logAPI(type: .error, url: targe.path, response: error)
                onFailure(error.errorDescription ?? "")
            }
        }
    }
    
    
}

extension ApiErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidDowncasting:
            return "Failed to downcast api response."
        case .invalidResponse:
            return "API response is invalid."
        case .failToParse:
            return "Failed to parse data into json object."
        case .noInternet:
            return "Internet connect is not available."
        }
    }
}
