//
//  APITarget.swift
//  rick-and-morty
//
//  Created by Anna Gromova on 08.07.2023.
//

import Moya
import Foundation

enum APITarget {
    case getCharacters
}

extension APITarget: TargetType {

    var baseURL: URL {
        guard let url = URL(string: "https://rickandmortyapi.com/api") else {
            fatalError("Could not access url")
        }
        return url
    }

    var path: String {
        switch self {
        case .getCharacters:
            return "/character"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Moya.Task {
        .requestPlain
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
