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
//            self.fetchDummyData()
            self.fetchOrderBook()
        }
    }
    
    func fetchOrderBook() {
        let url = URL(string: "https://api.upbit.com/v1/orderbook?markets=\(marketData.market)")!
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([OrderBookModelElement].self, from: data)
                print("-- 디코딩 성공", Int.random(in: 1...1000))
//                print(decodedData)
                print("개수 : ", decodedData.first?.orderbookUnits.count)
                
                DispatchQueue.main.async {
                    let unitResult = decodedData.first?.orderbookUnits ?? [OrderbookUnit(askPrice: 0, bidPrice: 0, askSize: 0, bidSize: 0)]
                    
                    let ask = unitResult.map { OrderBookItem(price: $0.askPrice, size: $0.askSize) }.sorted(by: { $0.price > $1.price })
                    let bid = unitResult.map { OrderBookItem(price: $0.bidPrice, size: $0.bidSize) }.sorted(by: { $0.price > $1.price })
                    
                    self?.askOrderBook = ask
                    self?.bidOrderBook = bid
                }
            } catch {
                print("-- 디코딩 실패", Int.random(in: 1...1000))
                do {
                    let decodedError = try JSONDecoder().decode(ErrorAPIModel.self, from: data)
                    print(decodedError)
                } catch {
                    print("디코딩 실패 에러마저 디코딩 실패")
                }
            }
            
        }.resume()
    }
    
}
