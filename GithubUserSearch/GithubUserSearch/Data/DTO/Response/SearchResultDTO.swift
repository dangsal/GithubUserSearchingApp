//
//  SearchResultDTO.swift
//  GithubUserSearch
//
//  Created by 이성호 on 10/6/23.
//

import Foundation

struct SearchResult: Decodable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [UserInfoDTO]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
