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

/// This calendar variant respects the original Article X: a year is sextil every 4 years, starting with year 3.
struct OriginalArticleXVariant: RepublicanCalendarVariant {
    func isYearSextil(_ year: Int) -> Bool {
        year % 4 == 3
    }
}

extension RepublicanCalendarVariant where Self == OriginalArticleXVariant {
    static var original: Self { OriginalArticleXVariant() }
}
