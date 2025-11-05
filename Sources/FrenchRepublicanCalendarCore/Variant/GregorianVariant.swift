//
//  GregorianVariant.swift
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

/// This calendar variant implements isYearSextil to represent gregorian bissextil years. For internal usage.
struct GregorianVariant: CalendarVariant {
    func isYearSextil(_ year: Int) -> Bool {
        ((year % 100 != 0) && (year % 4 == 0)) || year % 400 == 0
    }
}

extension CalendarVariant {
    var gregorian: GregorianVariant {
        GregorianVariant()
    }
}
