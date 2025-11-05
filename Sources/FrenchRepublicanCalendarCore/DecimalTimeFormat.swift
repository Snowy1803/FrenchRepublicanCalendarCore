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

public enum DecimalTimeComponentFormat: Codable, Hashable {
    // None
    case none
    // 8
    case short
    // 08
    case long
    // short (hour) or long (minute and second)
    case `default`
}

public typealias HourFormat = DecimalTimeComponentFormat
public typealias MinuteFormat = DecimalTimeComponentFormat
public typealias SecondFormat = DecimalTimeComponentFormat

public enum SubSecondFormat: Codable, Hashable {
    // No subsecond
    case none
    // .xxx (n digits)
    case precision(Int)
}

public struct DecimalTimeFormat: Codable, FormatStyle {
    public typealias FormatInput = DecimalTime
    public typealias FormatOutput = String
    
    public var hour: HourFormat = .none
    public var minute: MinuteFormat = .none
    public var second: SecondFormat = .none
    public var subsecond: SubSecondFormat = .none
    
    public func formatHour(_ time: DecimalTime) -> String? {
        switch hour {
        case .none:
            return nil
        case .short, .default:
            return "\(time.hour)"
        case .long:
            return String("0\(time.hour)".suffix(2))
        }
    }
    
    public func formatMinute(_ time: DecimalTime) -> String? {
        switch minute {
        case .none:
            return nil
        case .short:
            return "\(time.minute)"
        case .long, .default:
            return String("0\(time.minute)".suffix(2))
        }
    }
    
    public func formatSecond(_ time: DecimalTime) -> String? {
        switch second {
        case .none:
            return nil
        case .short:
            return "\(time.second)"
        case .long, .default:
            return String("0\(time.second)".suffix(2))
        }
    }
    
    public func formatSubSecond(_ time: DecimalTime) -> String {
        switch subsecond {
        case .none, .precision(0):
            return ""
        case .precision(let length):
            let formatter = NumberFormatter()
            formatter.locale = .init(identifier: "en-US")
            formatter.minimumFractionDigits = length
            formatter.maximumFractionDigits = length
            return "\(formatter.string(from: time.remainder as NSNumber)!.dropFirst())"
        }
    }
    
    public func format(_ time: DecimalTime) -> String {
        let components: String = [
            formatHour(time),
            formatMinute(time),
            formatSecond(time)
        ].compactMap { $0 }.joined(separator: ":")
        return components + formatSubSecond(time)
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == DecimalTimeFormat {
    public static var decimalTime: DecimalTimeFormat { DecimalTimeFormat() }
}

extension DecimalTimeFormat {
    public func hour(_ style: HourFormat = .default) -> Self {
        var copy = self
        copy.hour = style
        return copy
    }

    public func minute(_ style: MinuteFormat = .default) -> Self {
        var copy = self
        copy.minute = style
        return copy
    }

    public func second(_ style: SecondFormat = .default) -> Self {
        var copy = self
        copy.second = style
        return copy
    }

    public func subsecond(_ style: SubSecondFormat) -> Self {
        var copy = self
        copy.subsecond = style
        return copy
    }
}
