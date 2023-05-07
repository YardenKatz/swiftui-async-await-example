//
//  PeopleListViewModel.swift
//  StarWarsSwiftUI
//
//  Created by ירדן כץ on 04/04/2023.
//

import Foundation
import SwiftUI

@MainActor final class PeoplListViewModel: ObservableObject {
    
    @Published var peopleList =  [Person]()
    @Published var next: String?
    @Published var peopleListLoadingError: String = ""
    @Published var showAlert: Bool = false
    @Published var isLoading = false
    @Published var favorite: String?
    
    var dataManager: NetworkManagerProtocol
    
    init(dataManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.dataManager = dataManager
    }
    
    func getPeopleList(url: String? = nil) async {
        isLoading = true

        let dataResponse = await dataManager.fetchPeopleList(url: url ?? dataManager.baseUrl())
        if let error = dataResponse.error  {
            createAlert(with: error)
        } else {
            peopleList.append(contentsOf: dataResponse.value!.results ?? [])
            next = dataResponse.value!.next
        }
        
        isLoading = false
    }
    
    func createAlert( with error: Error ) {
        print(error) // log
    }
}

