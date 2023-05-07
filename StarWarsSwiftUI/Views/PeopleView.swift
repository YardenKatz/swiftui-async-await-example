//
//  ContentView.swift
//  StarWarsSwiftUI
//
//  Created by ירדן כץ on 04/04/2023.
//

import SwiftUI

struct PeopleList: View {
    @ObservedObject var viewModel = PeoplListViewModel()
    
    var body: some View {
        ZStack {
            List(viewModel.peopleList, id: \.name) { person in
                PersonView(person: person)
                    .task() {
                        if person.name == viewModel.peopleList.last?.name {
                            if let next = viewModel.next {
                                await viewModel.getPeopleList(url: next)
                            } else {
                                viewModel.peopleList.sort { person_1, person_2 in
                                    Int(person_1.height ?? "") ?? 0 < Int(person_2.height ?? "") ?? 0
                                }
                            }
                        }
                        
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.favorite = person.name
                    }
                    .listRowBackground(person.name == viewModel.favorite ? Color.gray : Color.white)
            }
            if viewModel.isLoading {
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            }
        }
        .task {
            await viewModel.getPeopleList()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleList()
    }
}
