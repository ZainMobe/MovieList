//
//  NetworkManager.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//
import Moya
import Foundation

/// The purpose of the `ApiManager` is to provide an Shared instant to get access of Moya services. This will be used to get any network service.
class ApiNetworkManager {
    /// Singleton object
    static let shared = ApiNetworkManager()
    /// An instant to access Network Service Enum.
    let provider: MoyaProvider<NetworkService>
    /// Default private initialiser
    private init() {
        self.provider =  MoyaProvider<NetworkService>()
    }

}
/// All Network services will be called here in a simple enum. Just make a new "case" in case of calling new APi.
enum NetworkService {
    case getMovieList(params: [String: Any])
    case searchMovie(params: [String: Any])
    case posterImage(poster_path: String)
}
// MARK: - TargetType Protocol Implementation
extension NetworkService: TargetType {
    /// Main URL to be set
    var baseURL: URL {
        switch self {
        case .posterImage(let poster_path):
            return URL(string: ApiConstant.posterImage + poster_path)!
        default:
            return URL(string: ApiConstant.baseURL)!
        }
    }
    /// End points of all cases you make in enum.
    var path: String {
        switch self {
        case .getMovieList:
            return ApiConstant.movieList
        case .searchMovie:
            return ApiConstant.searchMovie
        case .posterImage:
            return ""
        }
        
    }
    /// What type of method it will be? Post,Get,Pull etc
    var method: Moya.Method {
        switch self {
        case .getMovieList:
            return .get
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    /// Handle your task here, Add parameters here
    var task: Task {
        switch self {
        case let .getMovieList(params: params),
            let .searchMovie(params: params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .posterImage:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        }
    }
}
