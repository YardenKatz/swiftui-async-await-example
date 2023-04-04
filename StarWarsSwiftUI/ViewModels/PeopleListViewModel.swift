//
//  PeopleListViewModel.swift
//  StarWarsSwiftUI
//
//  Created by ירדן כץ on 04/04/2023.
//

import Foundation
import Combine
final class PeoplListViewModel: ObservableObject {
    
    @Published var peopleList =  [Person]()
    @Published var peopleListLoadingError: String = ""
    @Published var showAlert: Bool = false

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: NetworkManagerProtocol
    
    init(dataManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.dataManager = dataManager
        getPeopleList()
    }
    
    func getPeopleList() {
        dataManager.fetchPeopleList()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.peopleList = dataResponse.value!.results ?? []
                }
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: NetworkError ) {
        peopleListLoadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}

