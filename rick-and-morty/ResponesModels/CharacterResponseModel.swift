//
//  CharacterResponseModel.swift
//  rick-and-morty
//
//  Created by Anna Gromova on 08.07.2023.
//

import Foundation

struct CharacterResponseModel: Codable {
    struct Location: Codable {
        var name: String
        let url: String
    }
    
    let id: Int
    let name: String
    var status: String
    let species: String
    let gender: String
    var location: Location
    let image: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case species
        case gender
        case image
        case status
        case location
    }
}
