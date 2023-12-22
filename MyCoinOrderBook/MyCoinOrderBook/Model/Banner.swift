//
//  Banner.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import SwiftUI

struct Banner: Hashable, Identifiable {
    let id = UUID()
    var total = Int.random(in: 1000...5000) * 150
    let color = Color.random()
    
    var totalFormat: String {
        return "\(total.formatted()) 원"
    }
}

extension Color {
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
