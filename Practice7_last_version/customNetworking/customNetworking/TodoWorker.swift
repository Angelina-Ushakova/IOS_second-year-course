//
//  TodoWorker.swift
//  customNetworking
//
//  Created by Aleksa Khruleva on 01.12.2023.
//

import Foundation

struct Todo: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

enum TodoEndpoint: Endpoint {
    case todo(Int)
    
    var compositePath: String {
        switch self {
        case .todo(let number):
            "/todos/\(number)"
        }
    }
    
    var headers: HeaderModel { [:] }
}


final class TodoWorker {
    typealias TodoResult = (Result<Todo, Error>) -> Void
    
    private let networking: Networking = Networking(baseUrl: "https://jsonplaceholder.typicode.com")
    
    func fetchTodos(completion: @escaping TodoResult) {
        let endpoint = TodoEndpoint.todo(1)
        let request = Request(endpoint: endpoint, method: .get)
        networking.executeRequest(with: request) { result in
            switch result {
            case .success(let model):
                if let data = model.data {
                    print(String(data: data, encoding: .utf8) as Any)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
