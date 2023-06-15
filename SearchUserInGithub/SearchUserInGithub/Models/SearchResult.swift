//
//  SearchResult.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/15.
//

import Foundation

struct SearchResult: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [User]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
