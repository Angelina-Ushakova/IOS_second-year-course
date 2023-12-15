//
//  ArticlesEndpoint.swift
//  customNetworking
//
//  Created by admin on 15.12.2023.
//

import Foundation

enum ArticlesEndpoint: Endpoint {
    case news(rubricId: Int, pageindex: Int)
    var compositePath: String {
        switch self {
        case .news:
            return "todos/3"
        }
    }
    
    var headers: HeaderModel {[:]}
}
