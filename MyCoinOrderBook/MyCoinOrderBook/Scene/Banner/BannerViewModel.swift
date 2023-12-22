//
//  BannerViewModel.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import Foundation

class BannerViewModel: ObservableObject {
    
    @Published var banner = Banner()
    
    
    func fetchBanner() {
        banner = Banner()
    }
    
}
