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
}

struct NetworkManager {
    static let shared: NetworkManagerProtocol = NetworkManager()
    private init() {}

    static let baseURL = "https://swapi.dev/api"
    
    enum Endpoint {
        case people
        
        var page : Int {
            1
        }
        
        var path: String {
            switch self {
            case .people: return "/people/?page=\(page)"
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
    func fetchPeopleList(url: String = Endpoint.people.url) -> AnyPublisher<DataResponse<PeopleListModel, NetworkError>, Never> {
        
        return AF.request(url,
                          method: .get)
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
}



