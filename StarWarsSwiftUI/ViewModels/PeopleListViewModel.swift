//
//  PeopleListViewModel.swift
//  StarWarsSwiftUI
//
//  Created by ירדן כץ on 04/04/2023.
//

import Foundation
import SwiftUI
import Combine

final class PeoplListViewModel: ObservableObject {
    
    @Published var peopleList =  [Person]()
    @Published var next: String?
    @Published var peopleListLoadingError: String = ""
    @Published var showAlert: Bool = false

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: NetworkManagerProtocol
    
    init(dataManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.dataManager = dataManager
        getPeopleList()
    }
    
    func getPeopleList(url: String? = nil) {
        dataManager.fetchPeopleList(url: url ?? Constants.baseEndpoint)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.peopleList.append(contentsOf: dataResponse.value!.results ?? [])
                    self.next = dataResponse.value!.next
                }
            }.store(in: &cancellableSet)
    }
    
    
    func createAlert( with error: NetworkError ) {
        peopleListLoadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}

