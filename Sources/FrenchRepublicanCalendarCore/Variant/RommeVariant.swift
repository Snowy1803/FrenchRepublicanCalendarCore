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

/// This calendar respects the Romme variation of Article X: a year is sextil every 4 years, except every 100 years, except every 400 years, except every 4000 years
struct RommeVariant: RepublicanCalendarVariant {
    func isYearSextil(_ year: Int) -> Bool {
        (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0) && (year % 4000 != 0)
    }
}

extension RepublicanCalendarVariant where Self == RommeVariant {
    static var romme: Self { RommeVariant() }
}
