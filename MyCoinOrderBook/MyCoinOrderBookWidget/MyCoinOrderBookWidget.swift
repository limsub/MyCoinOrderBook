//
//  MyCoinOrderBookWidget.swift
//  MyCoinOrderBookWidget
//
//  Created by 임승섭 on 12/23/23.
//

import WidgetKit
import SwiftUI



// 위젯의 정보
struct MyCoinOrderBookWidget: Widget {
    let kind: String = "MyCoinOrderBookWidget"  // 위젯을 구분해주는 고유한 문자열

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MyCoinOrderBookWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MyCoinOrderBookWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("보유 코인")  // 위젯을 추가하는 부분에서 나오는 title과 description
        .description("실시간 시세를 확인하세요")
        .supportedFamilies([.systemSmall, .systemLarge, .systemMedium])
    }
}



//#Preview(as: .systemSmall) {
//    MyCoinOrderBookWidget()
//} timeline: {
//    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
//}
