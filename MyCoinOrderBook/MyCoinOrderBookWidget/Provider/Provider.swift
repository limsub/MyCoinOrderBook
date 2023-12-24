//
//  Provider.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/23/23.
//

import WidgetKit

// Provider : 사용자가 설정한 시간에 맞춰 위젯을 업데이트 할 수 있도록 한다
// "어떤 시간대에 어떻게 업데이트할 건지"
struct Provider: TimelineProvider {
    
    typealias Entry = SimpleEntry // 위젯의 데이터 구조체
    
    
    // 위젯을 최초로 렌더링할 때 사용 (스켈레톤 뷰 역할)
    func placeholder(in context: Context) -> SimpleEntry {
        // 데이터를 보여줄 때까지 걸리는 시간동안 보여주는 데이터 정도로 생각
        SimpleEntry(
            date: Date(),
            emoji: "😀",
            title: "플레이스 홀더 타이틀",
            price: 1200000
        )
    }

    // 위젯 갤러리 미리보기 화면 (위젯 추가할 때 확인)
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(
            date: Date(),
            emoji: "😎",
            title: "미리보기 타이틀",
            price: 16000000
        )
        completion(entry)
    }

    // 위젯 상태 변경 시점 (시간에 대한 핸들링)
    // 뷰를 미리 렌더링하고, 올린다. (위젯의 작동 방식 - WWDC)
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []


        let currentDate = Date()
        
        // 타임라인 배열
        for hourOffset in 0 ..< 30 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            
            let entry = SimpleEntry(
                date: entryDate,
                emoji: "😇",
                title: "타임라인 타이틀",
                price: 2000000
            )
            
            entries.append(entry)
        }

        // 타임라인의 마지막 요소가 지난 뒤, 위젯킷이 새로운 타임라인을 요청할 수 있도록 설정한다 (.atEnd)
        // .never : 요청 x
        // .after : 특정 시간 이후
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

