//
//  CoinListViewModel.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import Foundation

class CoinListViewModel: ObservableObject { // ObservableObject : 관찰할 수 있도록 자격을 준다
    
    @Published var market = [
        Market(market: "1", koreanName: "1번", englishName: "num 1"),
        Market(market: "2", koreanName: "2번", englishName: "num 2"),
        Market(market: "3", koreanName: "3번", englishName: "num 3")
    ]
    
    func fetchAllMarket() {
        
        guard let url = URL(string: "https://api.upbit.com/v1/market/all") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Market].self, from: data)
                
                DispatchQueue.main.async {
                    self?.market = decodedData
                }
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
}
