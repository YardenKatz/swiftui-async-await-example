//
//  PersonView.swift
//  StarWarsSwiftUI
//
//  Created by ירדן כץ on 04/04/2023.
//

import SwiftUI

struct PersonView: View {
    var person: Person
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(person.name)
            
            Spacer()
            
            Text(person.height)
                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Rectangle().stroke())
            Spacer()
        }
        .frame(height: CGFloat(Double(person.height) ?? 50))
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        let json = """
        {
        "name": "Luke Skywalker",
        "height": "172",
        "mass": "77",
        "hair_color": "blond",
        "skin_color": "fair",
        "eye_color": "blue",
        "birth_year": "19BBY",
        "gender": "male",
        "homeworld": "https://swapi.dev/api/planets/1/",
        "films": [
            "https://swapi.dev/api/films/1/",
            "https://swapi.dev/api/films/2/",
            "https://swapi.dev/api/films/3/",
            "https://swapi.dev/api/films/6/"
        ],
        "species": [],
        "vehicles": [
            "https://swapi.dev/api/vehicles/14/",
            "https://swapi.dev/api/vehicles/30/"
        ],
        "starships": [
            "https://swapi.dev/api/starships/12/",
            "https://swapi.dev/api/starships/22/"
        ],
        "created": "2014-12-09T13:50:51.644000Z",
        "edited": "2014-12-20T21:17:56.891000Z",
        "url": "https://swapi.dev/api/people/1/"
    }
    """
        let data = Data(json.utf8)
        let person = try? JSONDecoder().decode(Person.self, from: data)

        PersonView(person: person!)
    }
}
