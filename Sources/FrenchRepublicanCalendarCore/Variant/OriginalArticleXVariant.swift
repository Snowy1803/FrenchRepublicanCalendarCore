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
        if isYearBissextil(gYear) {
            increment(day: &dayOfYear, by: -1, year: &year)
        }
        
        let remdays = (gYear / 100 - 15) * 3 / 4 - 1
        increment(day: &dayOfYear, by: -remdays, year: &year)
        
        return (dayOfYear, year)
    }
}

private extension OriginalArticleXVariant {
    /// Returns true if the given gregorian year is bisextil
    func isYearBissextil(_ year: Int) -> Bool {
        ((year % 100 != 0) && (year % 4 == 0)) || year % 400 == 0
    }
}

extension RepublicanCalendarVariant where Self == OriginalArticleXVariant {
    static var original: Self { OriginalArticleXVariant() }
}
