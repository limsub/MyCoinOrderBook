//
//  Model.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/29/23.
//

import Foundation

struct OrderBookWS: Decodable {
  let timestamp: Int
  let totalAskSize, totalBidSize: Double
  let orderbookUnits: [OrderbookUnit]

  enum CodingKeys: String, CodingKey {
    case timestamp
    case totalAskSize = "total_ask_size"
    case totalBidSize = "total_bid_size"
    case orderbookUnits = "orderbook_units"
  }
}
