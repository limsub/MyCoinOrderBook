//
//  TestView.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/22/23.
//

import SwiftUI

struct TestView: View {
    
    @State var arr = ["1", "a", "b", "1231", "3213a", "wqerqb", "wqrewqer1", "reqrqea", "qweqweb", "dsvfadsv1", "qweefgga", "bvsda", "1eweq", "aqwqwr", "basdfasdf", "431412", "wqrwqr", "awerewr", "werwqtr"]
    
    @State var arr2 = ["123", "ab123123c", "easvf", "123qwe21", "abc1t3331qwfw", "esvzsf", "123343", "a12421bc", "513532ef", "12afaew3", "arqr  3qbc", "123123213ef", "1vzsfvds23", "abbsadvbdsaabc", "bsadbdef", "12412423", "abc1245125", "e32tqtf", "12bdb3", "abdsbfsfdc", "efsbdffdß"]
    
    
    var body: some View {
        ScrollView {
            
            GeometryReader { proxy in
                
                VStack {
                    // 1. arr
                    ForEach(arr, id: \.self) { item in
                        Text(item)
                            .frame(height: 70)
                            .background(.yellow)
                    }
                    
                    // 2. arr2
                    ForEach(arr2, id: \.self) { item in
                        Text(item)
                            .frame(height: 40)
                            .background(.red)
                    }
                    
                    
                }
                
            }
            .frame(height : 2000)
            
            
        }
    }
}

#Preview {
    TestView()
}
