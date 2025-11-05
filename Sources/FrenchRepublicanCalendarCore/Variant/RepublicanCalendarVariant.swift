//
//  RepublicanCalendarVariant.swift
//  FrenchRepublicanCalendarCore
// 
//  Created by Emil Pedersen on 05/11/2025.
//  Copyright © 2020 Snowy_1803. All rights reserved.
// 
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Foundation

protocol CalendarVariant {
    /// Returns true if the given year is sextil (6 days in month 13), false otherwise (5 days in month 13)
    func isYearSextil(_ year: Int) -> Bool
}

protocol RepublicanCalendarVariant: CalendarVariant {
    /// Convert from gregorian to republican calendar
    /// - Parameter date: a gregorian date
    /// - Parameter gregorianCalendar: the gregorian calendar being used, with the right time zone set
    /// - Returns: a tuple with a zero-indexed day in year (0-364/365), and a 1-indexed year number
    func convertToRepublican(gregorian date: Date, in gregorianCalendar: Calendar) -> (dayOfYear: Int, year: Int)
    /// Convert from republican to gregorian calendar
    /// - Parameter rDayInYear the day in republican year (1-indexed)
    /// - Parameter rYear the republican year number (1-indexed) 
    /// - Parameter gregorianCalendar: the gregorian calendar being used, with the right time zone set
    /// - Returns: a tuple with a zero-indexed day in year (0-364/365), and a 1-indexed year number
    func convertToGregorian(rDayInYear: Int, rYear: Int, in gregorianCalendar: Calendar) -> (dayOfYear: Int, year: Int)
}

extension CalendarVariant {
    func daysInYear(for year: Int) -> Int {
        if isYearSextil(year) {
            366
        } else {
            365
        }
    }
    
    /// Increments the day component, and if it overflows, updates the year value
    /// - Parameters:
    ///   - add: The number of days to add (or remove if negative) to/from ourself
    ///   - year: The inout year, updated if necessary
    ///   - daysInYear: A keypath in Int returning an Int: "\.daysInXxxYear"
    func increment(day: inout Int, by add: Int, year: inout Int) {
        let division = (day + add).quotientAndRemainder(dividingBy: daysInYear(for: year))
        day = division.remainder
        year += division.quotient
        if day < 0 {
            year -= 1
            day += daysInYear(for: year)
        }
    }
}
