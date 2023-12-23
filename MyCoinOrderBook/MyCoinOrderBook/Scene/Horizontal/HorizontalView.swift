//
//  HorizontalView.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import SwiftUI

struct HorizontalView: View {
    
    @StateObject var viewModel = HorizontalViewModel(market: Market(market: "KRW-BTC", koreanName: "비트코인", englishName: "num 1"))
    
    
    var body: some View {
        NavigationView {
            
            ScrollView {

                // GoemetryReader : 그 자체로 'View'이며, container 안의 View 스스로의 크기와 위치를 함수로 정의한다
                // '상위 View가 GeometryReader에게 제안한 위치, 크기에 대한 정보에 접근할 수 있게 한다'
                // proxy : GeometryReader에게 할당된 크기, 위치를 뜻한다.
                
                
                GeometryReader { proxy in
                    
                    let graphWidth = proxy.size.width * 0.3 // 기기 사이즈의 0.6 만큼 쓰겠다
                    
                    VStack(alignment: .center) {
                        // 1. ask
                        ForEach(viewModel.askOrderBook, id: \.self) { item in
                            
                            HStack(alignment: .center) {
                                // 1.
                                ZStack(alignment: .trailing) {
                                    let graphSize = CGFloat(item.size) / CGFloat(viewModel.largestAskSize()) * graphWidth
                                    
                                    Rectangle()
                                        .foregroundColor(Color(hexString: ConstantColor.blueGraphColor.hexCode))
                                        .frame(maxWidth: graphSize, alignment: .trailing)
                                        .frame(height: 20)
                                    
                                    Text("\(item.size)")
                                        .frame(width: graphWidth)
                                    
                                }
                                .frame(maxWidth: graphWidth)
                                .frame(height: 40)
                                .background(Color(hexString: ConstantColor.blueBackgroundColor.hexCode))
                                
                                // 2.
                                Text("\(item.price.formatted())")
                                    .frame(width: proxy.size.width * 0.3)
                                    .frame(height: 40)
                                    .foregroundStyle(Color(hexString: ConstantColor.blueTextColor.hexCode))
                                    .background(Color(hexString: ConstantColor.blueBackgroundColor.hexCode))
                                
                                // 3.
                                Spacer()
                                    .frame(width: proxy.size.width * 0.3)
                            }
                            .frame(height: 40)
                            
                        }
                        
                        
                        // 2. bid
                        ForEach(viewModel.bidOrderBook, id: \.self) { item in
                            
                            HStack(alignment: .center) {
                                // 1.
                                Spacer()
                                    .frame(width: proxy.size.width * 0.35)
                                
                                // 2.
                                Text("\(item.price.formatted())")
                                    .frame(width: proxy.size.width * 0.3)
                                    .frame(height: 40)
                                    .foregroundStyle(Color(hexString: ConstantColor.blueTextColor.hexCode))
                                    .background(Color(hexString: ConstantColor.redBackgroundColor.hexCode))
                                
                                // 3.
                                ZStack(alignment: .leading) {
                                    
                                    let graphSize = CGFloat(item.size) / CGFloat(viewModel.largestBidSize()) * graphWidth
                                    
                                    Rectangle()
                                        .foregroundColor(Color(hexString: ConstantColor.redGraphColor.hexCode))
                                        .frame(maxWidth: graphSize, alignment: .leading)
                                        .frame(height: 20)
                                    
                                    Text("\(item.size)")
                                        .frame(width: graphWidth)
                                    
                                }
                                .frame(maxWidth: graphWidth)
                                .frame(height: 40)
                                .background(Color(hexString: ConstantColor.redBackgroundColor.hexCode))
                                           
                            }
                            .frame(height: 40)
                        }
                    }
                }
                .frame(height : 1440) // 40 * 15 * 2 + 40 + 40
                
            }
            .onAppear {
                viewModel.fetchOrderBook()
            }
            .navigationTitle(viewModel.marketData.koreanName)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
        }
            
        
    }
}

#Preview {
    HorizontalView()
}
