//
//  UserDefaults+Extension.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/24/23.
//

import Foundation

extension UserDefaults {
    static var groupShared: UserDefaults {
        let appGroupID = "group.widgetTest.myCoinOrderBook"
        return UserDefaults(suiteName: appGroupID)!
    }
}
