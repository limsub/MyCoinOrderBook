//
//  CoinListView.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import SwiftUI

struct CoinListView: View {
    
    @ObservedObject var viewModel = CoinListViewModel()
    
    
    var body: some View {
        
        LazyVStack {
            Button("임의의 데이터 호출 버튼") {
                viewModel.fetchAllMarket()
            }
            .background(.yellow)
            
            ForEach(viewModel.market, id: \.self) { item in
                NavigationLink(value: item) {
                    HStack {
                        VStack(alignment: .center) {
                            
                            Text(item.koreanName)
                                .fontWeight(.bold)
                            
                            Text(item.englishName)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        Text(item.market)
                    }
                    .padding(18)
                }
                
            }
        }
        .navigationDestination(for: Market.self) { item  in
//            let viewModel = Hori
        }
        
    }
}

#Preview {
    CoinListView()
}
