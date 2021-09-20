//
//  DecimalTime.swift
//  FrenchRepublicanCalendarCore
//
//  Created by Emil Pedersen on 29/05/2021.
//  Copyright © 2020 Snowy_1803. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Foundation

public struct DecimalTime {
    /// The TimeInterval (number of SI seconds) for a decimal second
    public static let decimalSecond: TimeInterval = 0.864
    public static let midnight = DecimalTime(hour: 0, minute: 0, second: 0, remainder: 0)
    
    public var hour: Int // 0..<10
    public var minute: Int // 0..<100
    public var second: Int // 0..<100
    public var remainder: Double // 0..<1
    
    /// Creates a new DecimalTime with the given time interval, in SI seconds
    public init(timeSinceMidnight time: TimeInterval) {
        self = .midnight
        timeSinceMidnight = time
    }
    
    /// Creates a new DecimalTime with the given values
    public init(hour: Int, minute: Int, second: Int, remainder: Double) {
        assert((0..<10).contains(hour))
        assert((0..<100).contains(minute))
        assert((0..<100).contains(second))
        assert((0..<1).contains(remainder))
        self.hour = hour
        self.minute = minute
        self.second = second
        self.remainder = remainder
    }
    
    /// The number of decimal seconds since midnight
    public var decimalTime: Double {
        get {
            Double(hour * 10000 + minute * 100 + second) + remainder
        }
        set {
            assert((0..<100000).contains(newValue))
            let decimal = Int(newValue)
            hour = decimal / 10000
            minute = (decimal % 10000) / 100
            second = decimal % 100
            remainder = newValue - Double(decimal)
        }
    }
    
    /// The number of SI seconds since midnight
    public var timeSinceMidnight: TimeInterval {
        get {
            decimalTime * DecimalTime.decimalSecond
        }
        set {
            decimalTime = newValue / DecimalTime.decimalSecond
        }
    }
}

public extension DecimalTime {
    /// Initializes a new DecimalTime with the current time
    init(base: Date = Date()) {
        let midnight = Calendar.gregorian.startOfDay(for: base)
        self.init(timeSinceMidnight: base.timeIntervalSinceReferenceDate - midnight.timeIntervalSinceReferenceDate)
    }
}

extension DecimalTime: CustomStringConvertible {
    /// Returns a description, without the remainder, in the `h:mm` format
    public var hourAndMinuteFormatted: String {
        "\(hour):\(("0" + String(minute)).suffix(2))"
    }
    
    /// Returns a description, without the remainder, in the `h:mm:ss` format
    public var hourMinuteSecondsFormatted: String {
        "\(hourAndMinuteFormatted):\(("0" + String(second)).suffix(2))"
    }
    
    /// Returns a description, without the remainder, in the `h:mm:ss` format
    public var description: String {
        hourMinuteSecondsFormatted
    }
}

extension DecimalTime: CustomDebugStringConvertible {
    /// Returns a complete description, in the `h:mm:ss.xxx` format. Keep in mind the remainder will not be rounded.
    public var debugDescription: String {
        "\(description)\(String(remainder).dropFirst())"
    }
}

public extension DecimalTime {
    /// The hour converted to SI units
    var hourSI: Int {
        get {
            Int(timeSinceMidnight) / 3600
        }
        set {
            timeSinceMidnight = TimeInterval(newValue * 3600 + minuteSI * 60) + secondSIPrecise
        }
    }
    
    /// The minute converted to SI units
    var minuteSI: Int {
        get {
            Int(timeSinceMidnight) % 3600 / 60
        }
        set {
            timeSinceMidnight = TimeInterval(hourSI * 3600 + newValue * 60) + secondSIPrecise
        }
    }
    
    /// The second converted to SI units, floored to an integer value
    var secondSI: Int {
        get {
            Int(timeSinceMidnight) % 60
        }
        set {
            timeSinceMidnight = TimeInterval(hourSI * 3600 + minuteSI * 60 + newValue)
        }
    }
    
    /// The second converted to SI units, and rounded to the nearest integer value
    var secondSIPrecise: TimeInterval {
        get {
            timeSinceMidnight.truncatingRemainder(dividingBy: 60)
        }
        set {
            timeSinceMidnight = TimeInterval(hourSI * 3600 + minuteSI * 60) + newValue
        }
    }
}
