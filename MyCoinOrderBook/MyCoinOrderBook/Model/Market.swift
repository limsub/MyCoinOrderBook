//
//  Market.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import Foundation

struct Market: Codable, Hashable {
    let id = UUID()
    
    let market: String
    let koreanName: String
    let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case market = "market"
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
