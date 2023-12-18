//
//  NetworkManager.swift
//  rick-and-morty
//
//  Created by Anna Gromova on 08.07.2023.
//

import Moya
import Foundation

protocol NetworkManagerProtocol {
    func fetchCharacters(completion: @escaping (Result<[CharacterResponseModel], Error>) -> Void)
}

final class NetworkManger: NetworkManagerProtocol {

    private var provider = MoyaProvider<APITarget>()

    func fetchCharacters(completion: @escaping (Result<[CharacterResponseModel], Error>) -> Void) {
        request(target: .getCharacters, completion: completion)
    }
}

private extension NetworkManger {

    func request<T:Decodable>(target: APITarget, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]
                    guard let resultsArray = json?["results"] as? [Any] else {
                        throw NSError(domain: "Error decoding results", code: -1, userInfo: nil)
                    }
                    let resultsData = try JSONSerialization.data(withJSONObject: resultsArray, options: [])
                    let results = try JSONDecoder().decode(T.self, from: resultsData)
                    completion(.success(results))
                }
                catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
