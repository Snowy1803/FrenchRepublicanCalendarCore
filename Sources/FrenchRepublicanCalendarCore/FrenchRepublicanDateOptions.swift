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

public struct FrenchRepublicanDateOptions: Hashable, Sendable {
    public static let `default` = FrenchRepublicanDateOptions(romanYear: false, variant: .original)
    
    public var romanYear: Bool
    public var variant: Variant
    public var timeZone: TimeZone? = nil
    
    public init(romanYear: Bool, variant: Variant, timeZone: TimeZone? = nil) {
        self.romanYear = romanYear
        self.variant = variant
        self.timeZone = timeZone
    }
    
    public enum Variant: Int, CaseIterable, Sendable {
        case original
        case romme
        case delambre
    }
}

public protocol SaveableFrenchRepublicanDateOptions {
    static var current: FrenchRepublicanDateOptions { get set }
}

extension FrenchRepublicanDateOptions.Variant {
    var impl: RepublicanCalendarVariant {
        switch self {
        case .original: return .original
        case .romme: return .romme
        case .delambre: return .delambre
        }
    }
    
    public func isYearSextil(_ year: Int) -> Bool {
        impl.isYearSextil(year)
    }
    
    public var maxSafeDate: Date {
        impl.maxSafeDate
    }
}

extension FrenchRepublicanDateOptions.Variant: CustomStringConvertible {
    public var description: String {
        switch self {
        case .original: return "Original"
        case .romme: return "Romme"
        case .delambre: return "Delambre"
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
    
    internal static func resolve(_ options: Self?) -> Self {
        if let options = options {
            return options
        } else if let type = FrenchRepublicanDateOptions.self as? SaveableFrenchRepublicanDateOptions.Type {
            return type.current
        } else {
            return .default
        }
    }
}

extension Calendar {
    /// Note: this depends on the current or default options — use options.gregorianCalendar to customize the TimeZone used by this calendar
    public static let gregorian: Calendar = {
        let options = FrenchRepublicanDateOptions.resolve(nil)
        return options.gregorianCalendar
    }()
}
