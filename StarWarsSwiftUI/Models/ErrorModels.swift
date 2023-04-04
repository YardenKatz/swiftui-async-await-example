//
//  ErrorModels.swift
//  StarWarsSwiftUI
//
//  Created by ירדן כץ on 04/04/2023.
//

import Foundation
import Alamofire

struct NetworkError: Error {
    // initial error is used in cases like network connection lost. see AF documentation
    
    let initialError: AFError
    let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
