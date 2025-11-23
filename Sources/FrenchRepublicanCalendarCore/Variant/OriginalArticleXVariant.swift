//
//  OriginalArticleXVariant.swift
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

/// This calendar variant respects the original Article X: a year is sextil every 4 years, starting with year 3.
struct OriginalArticleXVariant: RepublicanCalendarVariant {
    var maxSafeDate: Date {
        Date(timeIntervalSinceReferenceDate: 419644317600) // 15298 / 5 sansculottides 13508
    }

    func isYearSextil(_ year: Int) -> Bool {
        year % 4 == 3
    }
    
    func convertToRepublican(gregorian date: Date, in gregorianCalendar: Calendar) -> (dayOfYear: Int, year: Int) {
        let gYear = gregorianCalendar.dateComponents([.year], from: date).year!
        
        // no idea how it works, but it does
        var year: Int = gYear - 1791
        var dayOfYear: Int = gregorianCalendar.ordinality(of: .day, in: .year, for: date)!
        
        increment(day: &dayOfYear, by: -265, year: &year)
        
        if isYearSextil(gYear) {
            increment(day: &dayOfYear, by: -1, year: &year)
        }
        if gregorian.isYearSextil(gYear) {
            increment(day: &dayOfYear, by: -1, year: &year)
        }
        
        let remdays = (gYear / 100 - 15) * 3 / 4 - 1
        increment(day: &dayOfYear, by: -remdays, year: &year)
        
        return (dayOfYear, year)
    }
    
    func convertToGregorian(rDayInYear: Int, rYear: Int, in gregorianCalendar: Calendar) -> (dayOfYear: Int, year: Int) {
        var gYear = rYear + 1792
        var gDayOfYear = rDayInYear
        gregorian.increment(day: &gDayOfYear, by: -102, year: &gYear)
        
        var yt = 0
        var diff: Int
        repeat {
            diff = (gYear / 100 - 15) * 3 / 4 - 1 - yt
            gregorian.increment(day: &gDayOfYear, by: diff, year: &gYear)
            yt += diff
        } while diff != 0
        
        if isYearSextil(rYear - 1) && !(gYear % 4 == 0 && !gregorian.isYearSextil(gYear)) {
            gregorian.increment(day: &gDayOfYear, by: 1, year: &gYear)
        }
        
        return (gDayOfYear, gYear)
    }
}

extension RepublicanCalendarVariant where Self == OriginalArticleXVariant {
    static var original: Self { OriginalArticleXVariant() }
}
