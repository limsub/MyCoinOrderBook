//
//  BannerView.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import SwiftUI

struct BannerView: View {
    
    @ObservedObject var viewModel = BannerViewModel()
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(viewModel.banner.color)
                .overlay {
                    Circle()
                        .fill(.white.opacity(0.3))
                        .offset(x: -60, y: 40)
                        .scaleEffect(1.2, anchor: .bottomLeading)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))  // 영역을 깎아준다 (밖으로 삐져나오는 부분 없애주기)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
            
            
            VStack(alignment: .leading) {
                Spacer()
                Text("나의 소비내역")
                    .font(.title3)
                Text(viewModel.banner.totalFormat)
                    .font(.title)
                    .bold()
            }
            .visualEffect { content, geometryProxy in
//                content.offset(x: scrollOffset(geometryProxy))
//                content.offset(x: geometryProxy.frame(in: .global).origin.y)
                content.offset(x: -geometryProxy.bounds(of: .scrollView)!.minX - 20)
            }
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(8)
    }
    
    
    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        // VStack 기준으로 프레임을 먼저 가져와야 해. (어디서 멈출 지 알아야 하니까)
        let result = proxy.bounds(of: .scrollView)?.minX ?? 0
        return -result
    }
    
    
}

//#Preview {
//    BannerView()
//}
