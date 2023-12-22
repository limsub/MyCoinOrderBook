//
//  HorizontalData.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import Foundation

struct HorizontalData: Hashable, Identifiable {
    let id = UUID()
    let data: String
    let point = Int.random(in: 100...30000)
}
