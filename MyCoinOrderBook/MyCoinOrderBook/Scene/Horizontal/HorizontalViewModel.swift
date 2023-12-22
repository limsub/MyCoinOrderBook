//
//  HorizontalViewModel.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import Foundation

class HorizontalViewModel: ObservableObject {
    // ObservableObject: 데이터의 변경을 감지한다.
    
    @Published var value = 0.0  // @Published : (데이터가 변경되면) 신호를 보낸다
    @Published var dummy: [HorizontalData] = []
    
    @Published var askOrderBook: [OrderBookItem] = []
    @Published var bidOrderBook: [OrderBookItem] = []
    
    var marketData: Market
    
    init(market: Market) {
        self.marketData = market
    }
    
    func fetchDummyData() {
        dummy = [
            HorizontalData(data: "사과"),
            HorizontalData(data: "바나나"),
            HorizontalData(data: "포도"),
            HorizontalData(data: "파인애플"),
            HorizontalData(data: "참새"),
            HorizontalData(data: "기러기"),
            HorizontalData(data: "의자"),
            HorizontalData(data: "책상"),
            HorizontalData(data: "패딩"),
            HorizontalData(data: "바람막이"),
            HorizontalData(data: "맥북"),
            HorizontalData(data: "마우스"),
        ]
    }
    
    func largest() -> Int {
        let data = dummy.sorted(by: { $0.point > $1.point })
        return data.first?.point ?? 0
    }
    
    func largestAskSize() -> Double {
        let data = askOrderBook.sorted(by: { $0.size > $1.size })
        return data.first?.size ?? 0
    }
    
    func largestBidSize() -> Double {
        let data = bidOrderBook.sorted(by: { $0.size > $1.size })
        return data.first?.size ?? 0
    }
    
    func timer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.value += 1
            self.fetchDummyData()
        }
    }
    
}
