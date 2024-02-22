//
//  Optional.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import Foundation

extension Optional where Wrapped == String {
    var emptyIfNil: String {
        self ?? String()
    }
}
