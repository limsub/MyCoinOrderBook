//
//  MainView.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import SwiftUI

// ObservabledObject -> Published -> ObservedObject

// @StateObject : iOS 14
// : 상위 뷰가 다시 렌더링되도 하위 뷰의 데이터는 유지된다

// @ObservedObject : iOS 13
// : 상위 뷰가 다시 렌더링되면 하위 뷰도 전부 다시 렌더링된다

struct MainView: View {
    
    @ObservedObject var viewModel = MainViewModel()
    
    @State var renderingTestNum = 0
    

    
    var body: some View {
        
        NavigationStack {
            ScrollView {

                VStack {
                    // 1. 가로 스크롤 지갑
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(1..<50) { _ in
                                BannerView()
                                    .containerRelativeFrame(.horizontal)
//                                    .frame(width: UIScreen.main.bounds.width - 40)

                            }
                        }
                        .scrollTargetLayout()   // 스크롤하고자 하는 대상에 대한 레이아웃
                        
                    }
                    .scrollTargetBehavior(.viewAligned) // view 기준으로 중앙에 맞춘다
                    .safeAreaPadding([.horizontal],30) // 양 옆 객체가 살짝씩 보이게 한다
                    
                    
                    // 2. 세로 스크롤 리스트
                    CoinListView()
                }
            }
            .scrollIndicators(.hidden)  // 하나 쓰면 모든 ScrollView에 적용
            .refreshable {
                viewModel.markets.shuffle()
            }
            .navigationTitle("My Order Book")
        }
        
        
        
    }
    
    
    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        let result = proxy.bounds(of: .scrollView)?.minX ?? 0
        return -result
    }
}

#Preview {
    MainView()
}
