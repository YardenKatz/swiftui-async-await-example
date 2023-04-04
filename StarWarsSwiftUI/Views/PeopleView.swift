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
        List(viewModel.peopleList, id: \.name) { person in
            PersonView(person: person)
                .onAppear() {
                    if person.name == viewModel.peopleList.last?.name {
                       /* if let next = viewModel.next {
                            viewModel.getPeopleList(url: next) // TODO: need to use async await here and update view
                        } else { */
                            viewModel.peopleList.sort { person_1, person_2 in
                                Int(person_1.height) ?? 0 < Int(person_2.height) ?? 0
                            }
//                        }
                    }
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleList()
    }
}
