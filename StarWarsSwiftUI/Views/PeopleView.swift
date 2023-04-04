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
//        ScrollView {
//            LazyVStack {
//                ForEach(viewModel.peopleList, id: \.name) { person in
//                    HStack {
//
//                        // you can show image here by importing SDWebImageSwiftUI
//                        VStack(alignment: .leading) {
//                            Text(person.name)
//                                .foregroundColor(.white)
//                                .font(.custom("Avenir", size: 16))
//                                .fontWeight(.heavy)
//
////                            if chat.message != nil {
////                                HStack {
////                                    Text(chat.message!.content)
////                                        .foregroundColor(.white)
////                                        .font(.custom("Avenir", size: 14))
////                                        .lineLimit(1)
////
////                                    Text(chat.message!.created_at)
////                                        .foregroundColor(.white)
////                                        .font(.custom("Avenir", size: 14))
////                                }
////
////                            }
//
//                        }.padding(.horizontal)
//
//                        Spacer()
//
////                        if !chat.read {
////                            Circle()
////                                .fill(Color(UIColor(red: 0/255, green: 148/255, blue: 255/255, alpha: 1)))
////                                .frame(width: 14, height: 14)
////                        }
//
//                    }.padding(.vertical, 8)
//                    .padding(.horizontal)
////                    .background(!.read ? Color(UIColor(red: 83/255, green: 90/255, blue: 97/255, alpha: 1)) : Color.clear)
//                }
//            }
//        }
        
        List(viewModel.peopleList, id: \.name) { person in
            PersonView(person: person)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleList()
    }
}
