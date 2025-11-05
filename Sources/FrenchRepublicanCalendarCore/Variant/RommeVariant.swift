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
}

extension RepublicanCalendarVariant where Self == RommeVariant {
    static var romme: Self { RommeVariant() }
}
