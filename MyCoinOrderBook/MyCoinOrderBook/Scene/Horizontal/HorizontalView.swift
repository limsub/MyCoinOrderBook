//
//  HorizontalView.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import SwiftUI

struct HorizontalView: View {
    
    @StateObject var viewModel = HorizontalViewModel(market: Market(market: "1", koreanName: "1번", englishName: "num 1"))
    
    
    var body: some View {
        ScrollView {
            
            Text(viewModel.marketData.koreanName)
            
            // GoemetryReader : 그 자체로 'View'이며, container 안의 View 스스로의 크기와 위치를 함수로 정의한다
            // '상위 View가 GeometryReader에게 제안한 위치, 크기에 대한 정보에 접근할 수 있게 한다'
            // proxy : GeometryReader에게 할당된 크기, 위치를 뜻한다.
            GeometryReader { proxy in
                
                let graphWidth = proxy.size.width * 0.6 // 기기 사이즈의 0.6 만큼 쓰겠다
                
                VStack {
                    ForEach(viewModel.dummy, id: \.self) { item in
                        
                        HStack {
//                            Text("\(item.point.formatted())")
                            Text("\(item.data)")
                                .frame(width: proxy.size.width * 0.4)
                            
                            ZStack(alignment: .leading) {
                                
                                let graphSize = CGFloat(item.point) / CGFloat(viewModel.largest()) * graphWidth
                                
                                Rectangle()
                                    .foregroundColor(.blue.opacity(0.4))
                                    .frame(maxWidth: graphSize, alignment: .leading)
                                
                                Text("\(item.point)")
                                    .frame(width: graphWidth)
                                
                            }
                            .frame(width: .infinity)
                            .background(.gray)
                                       
                        }
                        .frame(height: 40)
                        
                    }
                }
                .background(.red)

            }
            
        }
        .onAppear {
            viewModel.fetchDummyData()
        }
    }
}

#Preview {
    HorizontalView()
}
