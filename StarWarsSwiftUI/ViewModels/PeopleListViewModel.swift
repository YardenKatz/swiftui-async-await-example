//
//  PeopleListViewModel.swift
//  StarWarsSwiftUI
//
//  Created by ירדן כץ on 04/04/2023.
//

import Foundation
import SwiftUI

final class PeoplListViewModel: ObservableObject {
    
    @MainActor @Published var peopleList =  [Person]()
    @Published var next: String?
    @Published var favorite: String?
    @MainActor @Published var isLoading = false
    
    var dataManager: NetworkManagerProtocol
    
    init(dataManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.dataManager = dataManager
    }
    
    func getPeopleList(url: String? = nil) async {
        await updateIsLoading(true)
        
        let dataResponse = await dataManager.fetchPeopleList(url: url ?? dataManager.baseUrl())
        if let error = dataResponse.error  {
            createAlert(with: error)
        } else {
            await updateModel(dataResponse.value?.results, next: dataResponse.value?.next)
        }
        
        await updateIsLoading(false)
    }
    
    @MainActor func updateIsLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    @MainActor func updateModel(_ peopleList: [Person]?, next: String?) {
        self.peopleList.append(contentsOf: peopleList ?? [])
        self.next = next
    }
    
    func createAlert( with error: Error ) {
        print(error) // log
    }
}

