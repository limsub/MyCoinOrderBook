//
//  OrderBookModel.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import Foundation

/* ===== 서버 모델 ===== */
struct OrderBookModelElement: Codable {
    let market: String
    let timestamp: Int
    let totalAskSize, totalBidSize: Double
    let orderbookUnits: [OrderbookUnit]

    enum CodingKeys: String, CodingKey {
        case market, timestamp
        case totalAskSize = "total_ask_size"
        case totalBidSize = "total_bid_size"
        case orderbookUnits = "orderbook_units"
    }
}

struct OrderbookUnit: Codable {
    let askPrice, bidPrice: Double
    let askSize, bidSize: Double

    enum CodingKeys: String, CodingKey {
        case askPrice = "ask_price"
        case bidPrice = "bid_price"
        case askSize = "ask_size"
        case bidSize = "bid_size"
    }
}

typealias OrderBookModel = [OrderBookModelElement]


/* ===== 뷰에서 사용할 모델 ===== */
struct OrderBookItem: Hashable, Identifiable {
    let id = UUID()
    let price: Double
    let size: Double
}

// 에러 모델
struct ErrorAPIModel: Codable {
    let name: String 
}
