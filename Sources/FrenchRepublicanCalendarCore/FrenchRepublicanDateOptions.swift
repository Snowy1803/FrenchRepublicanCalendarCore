//
//  FrenchRepublicanDateOptions.swift
//  FrenchRepublicanCalendar
//
//  Created by Emil Pedersen on 13/03/2021.
//  Copyright © 2021 Snowy_1803. All rights reserved.
//

import Foundation

public struct FrenchRepublicanDateOptions {
    
    public static let `default` = FrenchRepublicanDateOptions(romanYear: false, variant: .original)
    #if os(WASI)
    public static let current = FrenchRepublicanDateOptions.default
    #else
    public static var current: FrenchRepublicanDateOptions {
        get {
            FrenchRepublicanDateOptions(
                romanYear: UserDefaults.standard.bool(forKey: "frdo-roman"),
                variant: Variant(rawValue: UserDefaults.standard.integer(forKey: "frdo-variant")) ?? .original
            )
        }
        set {
            UserDefaults.standard.set(newValue.romanYear, forKey: "frdo-roman")
            UserDefaults.standard.set(newValue.variant.rawValue, forKey: "frdo-variant")
        }
    }
    #endif
    
    public var romanYear: Bool
    public var variant: Variant
    
    public enum Variant: Int {
        case original
    }
}
