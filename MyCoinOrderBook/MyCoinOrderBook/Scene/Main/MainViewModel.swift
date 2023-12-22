//
//  MainViewModel.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import Foundation

// VM은 body의 내용이 바뀌는지 관찰해야 한다 -> ObservedObject
// 내용이 바뀌면 신호를 줘야 한다 -> Published
// 보내는 신호를 받아야 한다 -> ObservedObject

// 즉, ObservableObject를 채택함으로써 VM의 데이터가 바뀌는지 관찰하고,
// 만약 변경이 감지되면 publish를 통해 뷰 업데이트를 도와준다.

// VM은 View가 아니기 때문에 @State가 필요하지 않다.
// 또한 View에서 접근할 수 있어야 하기 때문에 private도 덜어내준다.


class MainViewModel: ObservableObject {
    
    @Published var markets: [Market] = []
    
    func fetchAllMarket() {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Market].self, from: data)
                DispatchQueue.main.async {
                    self?.markets = decodedData
                }
            } catch {
                print(error)
            }
            
        }.resume()

    }

}
