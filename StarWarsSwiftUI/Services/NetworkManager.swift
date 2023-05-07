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
    func fetchPeopleList(url: String) async -> DataResponse<PeopleListModel, AFError>
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
    func fetchPeopleList(url: String) async -> DataResponse<PeopleListModel, AFError> {
        let dataTask = AF.request(url)
            .validate()
            .serializingDecodable(PeopleListModel.self)
        let response = await dataTask.response
        
        return response
    }
    
    func baseUrl() -> String {
        Endpoint.people.url
    }
    
    func log(_ error: Error) {
        print(error)
    }
}



