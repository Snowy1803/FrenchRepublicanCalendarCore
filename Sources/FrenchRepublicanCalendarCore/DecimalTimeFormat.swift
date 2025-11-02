//
//  FRCFormat.swift
//  FrenchRepublicanCalendarCore
//
//  Created by Emil on 06/03/2020.
//  Copyright © 2020 Snowy_1803. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Foundation

public enum DecimalTimePrecision: Codable, Hashable {
    // No time
    case none
    // 8:50
    case minutePrecision
    // 8:50:42
    case secondPrecision
    // 8:50:42.123 (when given 3)
    case subsecondPrecision(Int)
}

public struct DecimalTimeFormat: Codable, FormatStyle {
    public typealias FormatInput = DecimalTime
    public typealias FormatOutput = String
    
    public var precision: DecimalTimePrecision = .none
    
    public func format(_ time: DecimalTime) -> String {
        switch precision {
        case .none:
            return ""
        case .minutePrecision:
            return time.hourAndMinuteFormatted
        case .secondPrecision:
            return time.hourMinuteSecondsFormatted
        case .subsecondPrecision(let length):
            let formatter = NumberFormatter()
            formatter.locale = .init(identifier: "en-US")
            formatter.minimumFractionDigits = length
            formatter.maximumFractionDigits = length
            return "\(time.hourMinuteSecondsFormatted)\(formatter.string(from: time.remainder as NSNumber)!.dropFirst())"
        }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == DecimalTimeFormat {
    public static var decimalTime: DecimalTimeFormat { DecimalTimeFormat() }
}

extension DecimalTimeFormat {
    public func precision(_ style: DecimalTimePrecision) -> Self {
        var copy = self
        copy.precision = style
        return copy
    }
}

