//
//  RommeVariant.swift
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

/// This calendar respects the Romme variation of Article X: a year is sextil every 4 years, except every 100 years, except every 400 years, except every 4000 years
struct RommeVariant: RepublicanCalendarVariant {
    var maxSafeDate: Date {
        Date(timeIntervalSinceReferenceDate: 419698404000) // 15300-09-18 / 6 sansculottides 13508
    }

    func isYearSextil(_ year: Int) -> Bool {
        (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0) && (year % 4000 != 0)
    }
    
    func convertToRepublican(gregorian date: Date, in gregorianCalendar: Calendar) -> (dayOfYear: Int, year: Int) {
        // we're gonna base us upon the gregorian calendar. Unlike what the documentation says,
        // dates before 1572 use the julian calendar, so we're shifting to 2001 instead of year 1
        let shifted = gregorianCalendar.date(byAdding: .day, value: 76071, to: date)!
        var year = gregorianCalendar.component(.year, from: shifted) - 2000
        var dayOfYear = gregorianCalendar.ordinality(of: .day, in: .year, for: shifted)! - 1 // 1 to 0 indexed
        // still need to correct for the additional rule every 4000 years
        let remdays = (year - 1) / 4000
        increment(day: &dayOfYear, by: remdays, year: &year)
        
        return (dayOfYear, year)
    }
    
    func convertToGregorian(rDayInYear: Int, rYear: Int, in gregorianCalendar: Calendar) -> (dayOfYear: Int, year: Int) {
        // hour: 10 avoids a timezone change issue on 1911-03-11 (9 minutes 21 seconds change) if we're on an autoupdating timezone (as is the case by default)
        let date = gregorianCalendar.date(from: DateComponents(year: rYear + 2000, day: rDayInYear, hour: 10))!
        let shifted = gregorianCalendar.date(byAdding: .day, value: -76071, to: date)!
        var gYear = gregorianCalendar.component(.year, from: shifted)
        var gDayOfYear = gregorianCalendar.ordinality(of: .day, in: .year, for: shifted)! - 1
        let remdays = (rYear - 1) / 4000
        gregorian.increment(day: &gDayOfYear, by: -remdays, year: &gYear)
        
        return (dayOfYear: gDayOfYear, year: gYear)
    }
}

extension RepublicanCalendarVariant where Self == RommeVariant {
    static var romme: Self { RommeVariant() }
}
