//
//  EntryView.swift
//  MyCoinOrderBookWidgetExtension
//
//  Created by 임승섭 on 12/23/23.
//

import SwiftUI
import WidgetKit

// 위젯의 뷰를 디자인한다
struct MyCoinOrderBookWidgetEntryView : View {
    var entry: Provider.Entry   // 프로퍼티로 Entry에 대한 정보를 넣어준다

    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            Text(entry.emoji)
            Text(UserDefaults.groupShared.string(forKey: "Market") ?? "기본값" )
            Text(entry.title)
            Text(entry.price.formatted())
        }
    }
}
