//
//  NetworkManager.swift
//  StarWarsSwiftUI
//
//  Created by ירדן כץ on 04/04/2023.
//

import Foundation
import Combine
import Alamofire

protocol NetworkManagerProtocol {
    func fetchPeopleList(url: String) -> AnyPublisher<DataResponse<PeopleListModel, NetworkError>, Never>
    func baseUrl() -> String
}

struct NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    private init() {}

    static let baseURL = "https://swapi.dev/api"
    
    enum Endpoint {
        case people
        
        var path: String {
            switch self {
            case .people: return "/people/?page=1"
            }
        }
        
        var url: String {
            switch self {
            case .people: return "\(baseURL)\(path)"
            }
        }
    }
}

extension NetworkManager: NetworkManagerProtocol {
    func fetchPeopleList(url: String) -> AnyPublisher<DataResponse<PeopleListModel, NetworkError>, Never> {
        
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: PeopleListModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func baseUrl() -> String {
        Endpoint.people.url
    }
}



