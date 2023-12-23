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

            ForEach(viewModel.market, id: \.self) { item in
                NavigationLink(value: item) {
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text(item.koreanName)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            
                            Text(item.englishName)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        Text(item.market)
                            .foregroundStyle(.black)
                    }
                    .padding(18)
                }
                
            }
        }
        .onAppear {
            viewModel.fetchAllMarket()
        }
        .navigationDestination(for: Market.self) { item  in
            let viewModel = HorizontalViewModel(market: item)
            HorizontalView(viewModel: viewModel)
        }
        
    }
}

#Preview {
    CoinListView()
}
