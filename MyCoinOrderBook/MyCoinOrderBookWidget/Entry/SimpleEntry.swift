//
//  SimpleEntry.swift
//  MyCoinOrderBookWidgetExtension
//
//  Created by 임승섭 on 12/23/23.
//

import WidgetKit

struct SimpleEntry: TimelineEntry {
    // TimeLineEntry 프로토콜
    // -> date는 반드시 가지고 있어야 한다. 화면에 보여주지 않더라도, 렌더링 시점 때문에 반드시 프로퍼티로 넣어주어야 한다. (시간에 대한 관리)
    
    // relevance 프로퍼티도 있는데, 여러 개의 위젯을 넣을 때 우선순위를 결정해준다.
    
    let date: Date
    let emoji: String
    let title: String 
    let price: Int
}

