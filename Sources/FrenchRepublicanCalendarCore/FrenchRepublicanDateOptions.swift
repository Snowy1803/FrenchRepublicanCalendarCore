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
    
    /// If true, formatted dates in Sansculottides are things like "1 Sansculottides" instead of a holiday name.
    public var treatSansculottidesAsAMonth: Bool
    
    public init(romanYear: Bool, variant: Variant) {
        self.init(romanYear: romanYear, variant: variant, treatSansculottidesAsAMonth: false)
    }
    
    public init(romanYear: Bool, variant: Variant, treatSansculottidesAsAMonth: Bool) {
        self.romanYear = romanYear
        self.variant = variant
        self.treatSansculottidesAsAMonth = treatSansculottidesAsAMonth
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
