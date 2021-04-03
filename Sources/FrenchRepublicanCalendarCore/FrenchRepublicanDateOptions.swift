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
    
    public var romanYear: Bool
    public var variant: Variant
    
    public init(romanYear: Bool, variant: Variant) {
        self.romanYear = romanYear
        self.variant = variant
    }
    
    public enum Variant: Int {
        case original
    }
}

public protocol SaveableFrenchRepublicanDateOptions {
    static var current: FrenchRepublicanDateOptions { get set }
}
