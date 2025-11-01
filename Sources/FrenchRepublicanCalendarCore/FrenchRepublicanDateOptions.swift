//
//  FrenchRepublicanDateOptions.swift
//  FrenchRepublicanCalendarCore
//
//  Created by Emil Pedersen on 13/03/2021.
//  Copyright © 2021 Snowy_1803. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Foundation

public struct FrenchRepublicanDateOptions {
    public static let `default` = FrenchRepublicanDateOptions(romanYear: false, variant: .original)
    
    public var romanYear: Bool
    public var variant: Variant
    public var timeZone: TimeZone? = nil
    
    public init(romanYear: Bool, variant: Variant, timeZone: TimeZone? = nil) {
        self.romanYear = romanYear
        self.variant = variant
        self.timeZone = timeZone
    }
    
    public enum Variant: Int, CaseIterable {
        case original
        case romme
    }
}

public protocol SaveableFrenchRepublicanDateOptions {
    static var current: FrenchRepublicanDateOptions { get set }
}

extension FrenchRepublicanDateOptions.Variant {
    public func isYearSextil(_ year: Int) -> Bool {
        switch self {
        case .original:
            return year % 4 == 3
        case .romme:
            return (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0) && (year % 4000 != 0)
        }
    }
}

extension FrenchRepublicanDateOptions.Variant: CustomStringConvertible {
    public var description: String {
        switch self {
        case .original: return "Original"
        case .romme: return "Romme"
        }
    }
}

extension TimeZone {
    /// The meridional time of Paris, used in France until 1911
    public static var parisMeridian: TimeZone {
        TimeZone(secondsFromGMT: 9 * 60 + 21)!
    }
}

extension FrenchRepublicanDateOptions {
    public var currentTimeZone: TimeZone {
        self.timeZone ?? TimeZone.autoupdatingCurrent
    }
    
    public var gregorianCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "fr_FR")
        calendar.timeZone = self.currentTimeZone
        return calendar
    }
}
