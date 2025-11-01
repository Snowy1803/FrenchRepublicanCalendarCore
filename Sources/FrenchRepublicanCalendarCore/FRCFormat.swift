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

//let m = Date.FormatStyle

public enum WeekdayFormat: Codable {
    // No weekday
    case none
    // Weekday, except sansculottides
    case long
    // Always show weekday
    case always
}

public enum DayFormat: Codable {
    // No day
    case none
    // Véndémiaire or Sansculottides
    case monthOnly
    // Cheval or Vertu
    case dayName
    // 5 Véndémiaire or Jour de la vertu
    case preferred
}

public enum DayLengthFormat: Codable {
    // 5 Vend.r or Jr vertu
    case short
    // 5 Véndémiaire or Jour de la vertu
    case long
}

public enum YearFormat: Codable {
    // No year
    case none
    // XXX
    case short
    // An XXX
    case long
}

public struct FRCFormat: Codable, FormatStyle {
    public typealias FormatInput = FrenchRepublicanDate
    public typealias FormatOutput = String
    
    public var weekday: WeekdayFormat = .none
    public var day: DayFormat = .none
    public var dayLength: DayLengthFormat = .long
    public var year: YearFormat = .none
    
    func formatWeekday(date: FrenchRepublicanDate) -> String? {
        switch weekday {
        case .none:
            return nil
        case .long:
            if date.isSansculottides {
                return nil
            }
            fallthrough
        case .always:
            return date.weekdayName
        }
    }
    
    func formatMonth(date: FrenchRepublicanDate) -> String {
        switch dayLength {
        case .short:
            return date.shortMonthName
        case .long:
            return date.monthName
        }
    }
    
    func formatDay(date: FrenchRepublicanDate) -> String? {
        switch day {
        case .none:
            return nil
        case .monthOnly:
            return formatMonth(date: date)
        case .dayName:
            return date.dayName
        case .preferred:
            if date.isSansculottides {
                switch dayLength {
                case .short:
                    return date.shortSansculottideDayName
                case .long:
                    return date.sansculottideDayName
                }
            } else {
                return "\(date.components.day!) \(formatMonth(date: date))"
            }
        }
    }
    
    func formatYear(date: FrenchRepublicanDate) -> String? {
        switch year {
        case .none:
            return nil
        case .short:
            return date.formattedYear
        case .long:
            return "An \(date.formattedYear)"
        }
    }
    
    public func format(_ date: FrenchRepublicanDate) -> String {
        return [
            formatWeekday(date: date),
            formatDay(date: date),
            formatYear(date: date)
        ].compactMap(\.self).joined(separator: " ")
    }
}

extension FRCFormat {
    public static let veryLong = FRCFormat(weekday: .long, day: .preferred, year: .long)
    public static let long = FRCFormat(day: .preferred, year: .long)
    public static let dayMonth = FRCFormat(day: .preferred)
    public static let short = FRCFormat(day: .preferred, dayLength: .short)
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == FRCFormat {
    public static var republicanDate: FRCFormat { FRCFormat() }
}

extension FRCFormat {
    public func weekday(_ style: WeekdayFormat) -> Self {
        var copy = self
        copy.weekday = style
        return copy
    }
    public func day(_ style: DayFormat) -> Self {
        var copy = self
        copy.day = style
        return copy
    }
    public func dayLength(_ style: DayLengthFormat) -> Self {
        var copy = self
        copy.dayLength = style
        return copy
    }
    public func year(_ style: YearFormat) -> Self {
        var copy = self
        copy.year = style
        return copy
    }
}

