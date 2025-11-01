//
//  FrenchRepublicanCalendarCalculator.swift
//  FrenchRepublicanCalendarCore
//
//  Created by Emil on 06/03/2020.
//  Copyright © 2020 Snowy_1803. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Foundation

public struct FrenchRepublicanDate {
    
    // MARK: Static: Origin and Maximum
    
    /// The origin of the Republican Calendar, 1er Vendémiaire An 1 or 1792-09-22
    public static let origin = Date(timeIntervalSince1970: -5594191200)
    /// The maximum safe date to convert, currently 15300-12-31
    public static let maxSafeDate = Date(timeIntervalSinceReferenceDate: 419675853600) // 15299-12-31
    /// The safe range that is guaranteed to convert properly
    public static let safeRange = origin...maxSafeDate
    
    // MARK: Instance variables
    
    /// the system Date value for this Republican Date
    public var date: Date
    
    /// `year`: The year, starting at 1 for 1792-09-22,
    ///
    /// month: The month, 1-13 (13 being the additional days, called SANSCULOTTIDES),
    ///
    /// day: The day in the month 1-30 (1-5 or 1-6 for the 13th month, depending on .isYearSextil),
    ///
    /// hour, minute, second, nanosecond: The same as in the gregorian calendar (use DecimalTime if you want to convert them to decimal time),
    ///
    /// weekday: The weekday 1-10,
    ///
    /// quarter: The season, 1-5 (1=winter, 2=spring, 3=summer, 4=autumn, 5=SANSCULOTTIDES),
    ///
    /// weekOfMonth: The week within the month (a week being 10 days),
    ///
    /// weekOfYear: The week within the year (a week being 10 days)
    public var components: DateComponents!
    
    public private(set) var options: FrenchRepublicanDateOptions
    
    // MARK: Component accessors
    
    /// The day in year date component, 1-indexed
    public var dayInYear: Int {
        return (components.month! - 1) * 30 + components.day!
    }
    
    /// true if the current Republican year is sextil, false otherwise
    public var isYearSextil: Bool {
        return options.variant.isYearSextil(components.year!)
    }
    
    public var isSansculottides: Bool {
        return components.month == 13
    }
    
    // MARK: Initializers
    
    /// Creates a Republican Date from the given Gregorian Date
    /// - Parameter date: the Gregorian Date
    public init(date: Date, options: FrenchRepublicanDateOptions? = nil) {
        self.date = date
        self.options = .resolve(options)
        dateToFrenchRepublican()
    }
    
    /// Creates a Republican Date from Republican Date component. The `date` property will contain the Gregorian value, so this converts from Republican to Gregorian
    /// - Parameters:
    ///   - dayInYear: Day in Year, 1-indexed
    ///   - year: The republican Year
    ///   - hour: Hour
    ///   - minute: Minutes
    ///   - second: Seconds
    ///   - nanosecond: Nanoseconds
    public init(dayInYear: Int, year: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil, options: FrenchRepublicanDateOptions? = nil) {
        if let options = options {
            self.options = options
        } else if let type = FrenchRepublicanDateOptions.self as? SaveableFrenchRepublicanDateOptions.Type {
            self.options = type.current
        } else {
            self.options = .default
        }
        self.date = Date(dayInYear: dayInYear, year: year, hour: hour, minute: minute, second: second, nanosecond: nanosecond, options: self.options)
        initComponents(dayOfYear: dayInYear - 1, year: year, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
    }
    
    /// Logic that converts the `date` value to republican date components. Called by the Gregorian > Republican constructor
    private mutating func dateToFrenchRepublican() {
        let gregorianCalendar = options.gregorianCalendar
        let gregorian = gregorianCalendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: date)
        
        var year: Int
        var dayOfYear: Int
        
        switch options.variant {
        case .original:
            // no idea how it works, but it does
            let gYear = gregorian.year!
            year = gYear - 1791
            dayOfYear = gregorianCalendar.ordinality(of: .day, in: .year, for: date)!
            dayOfYear.increment(by: -265, year: &year, daysInYear: \.daysInOriginalRepublicanYear)
            
            if options.variant.isYearSextil(gYear) {
                dayOfYear.increment(by: -1, year: &year, daysInYear: \.daysInOriginalRepublicanYear)
            }
            if (gYear).isBissextil {
                dayOfYear.increment(by: -1, year: &year, daysInYear: \.daysInOriginalRepublicanYear)
            }
            
            let remdays = (gYear / 100 - 15) * 3 / 4 - 1
            dayOfYear.increment(by: -remdays, year: &year, daysInYear: \.daysInOriginalRepublicanYear)
        case .romme:
            // we're gonna base us upon the gregorian calendar. Unlike what the documentation says,
            // dates before 1572 use the julian calendar, so we're shifting to 2001 instead of year 1
            let shifted = gregorianCalendar.date(byAdding: .day, value: 76071, to: date)!
            year = gregorianCalendar.component(.year, from: shifted) - 2000
            dayOfYear = gregorianCalendar.ordinality(of: .day, in: .year, for: shifted)! - 1 // 1 to 0 indexed
            // still need to correct for the additional rule every 4000 years
            let remdays = (year - 1) / 4000
            dayOfYear.increment(by: remdays, year: &year, daysInYear: \.daysInRommeRepublicanYear)
        }
        
        initComponents(dayOfYear: dayOfYear, year: year, hour: gregorian.hour, minute: gregorian.minute, second: gregorian.second, nanosecond: gregorian.nanosecond)
    }
    
    /// Initializes the `components` property with the given values
    /// - Parameters:
    ///   - dayOfYear: Day of year, 0-indexed
    ///   - year: Year
    ///   - hour: Hour
    ///   - minute: Minutes
    ///   - second: Seconds
    ///   - nanosecond: Nanoseconds
    private mutating func initComponents(dayOfYear: Int, year: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil) {
        self.components = DateComponents(timeZone: options.timeZone, year: year, month: dayOfYear / 30 + 1, day: dayOfYear % 30 + 1, hour: hour, minute: minute, second: second, nanosecond: nanosecond, weekday: dayOfYear % 10 + 1, quarter: dayOfYear / 90 + 1, weekOfMonth: dayOfYear % 30 / 10 + 1, weekOfYear: dayOfYear / 10 + 1, yearForWeekOfYear: year)
    }
    
    // MARK: Mutating utils
    
    /// Increments the Republican year for this Date. The Gregorian `date` will be recomputed.
    public mutating func nextYear() {
        components.year! += 1
        components.yearForWeekOfYear! += 1
        date = Date(dayInYear: dayInYear, year: components.year!, hour: components.hour, minute: components.minute, second: components.second, nanosecond: components.nanosecond, options: options)
    }
}

fileprivate extension Int {
    /// If self represents a gregorian year, this returns true if it is bissextil
    var isBissextil: Bool {
        return ((self % 100 != 0) && (self % 4 == 0)) || self % 400 == 0
    }
    
    /// If self represents a republican year in the `.original` variant, this returns the number of days in itself
    var daysInOriginalRepublicanYear: Int {
        FrenchRepublicanDateOptions.Variant.original.isYearSextil(self) ? 366 : 365
    }
    
    /// If self represents a republican year in the `.romme` variant, this returns the number of days in itself
    var daysInRommeRepublicanYear: Int {
        FrenchRepublicanDateOptions.Variant.romme.isYearSextil(self) ? 366 : 365
    }
    
    /// If self represents a gregorian year, this returns the number of days in it
    var daysInGregorianYear: Int {
        isBissextil ? 366 : 365
    }
    
    /// Increments the day component, and if it overflows, updates the year value
    /// - Parameters:
    ///   - add: The number of days to add (or remove if negative) to/from ourself
    ///   - year: The inout year, updated if necessary
    ///   - daysInYear: A keypath in Int returning an Int: "\.daysInXxxYear"
    mutating func increment(by add: Int, year: inout Int, daysInYear: KeyPath<Int, Int>) {
        let division = (self + add).quotientAndRemainder(dividingBy: year[keyPath: daysInYear])
        self = division.remainder
        year += division.quotient
        if self < 0 {
            year -= 1
            self += year[keyPath: daysInYear]
        }
    }
}

internal extension Date {
    /// Creates a Date from the given Republican date components
    /// - Parameters:
    ///   - dayInYear: Republican Day in Year, 1-indexed
    ///   - year: Republican Year
    ///   - hour: Hour, will directly be copied over
    ///   - minute: Minute, will directly be copied over
    ///   - second: Second, will directly be copied over
    ///   - nanosecond: Nanosecond, will directly be copied over
    /// - Note: Library users: use FrenchRepublicanDate.init(dayInYear: ...).date
    init(dayInYear: Int, year: Int, hour: Int?, minute: Int?, second: Int?, nanosecond: Int?, options: FrenchRepublicanDateOptions) {
        self = options.gregorianCalendar.date(from: Date.dateToGregorian(dayInYear: dayInYear, year: year, hour: hour, minute: minute, second: second, nanosecond: nanosecond, options: options))!
    }
}

fileprivate extension Date {
    /// Converts a date from Republican to Gregorian date components.
    /// - Parameters:
    ///   - rDayInYear: Republican Day in Year, 1-indexed
    ///   - rYear: Republican Year
    ///   - hour: Hour, will directly be copied over
    ///   - minute: Minute, will directly be copied over
    ///   - second: Second, will directly be copied over
    ///   - nanosecond: Nanosecond, will directly be copied over
    /// - Returns: A DateComponents object containing the gregorian year and day of year, with the additional time components copied over.
    static func dateToGregorian(dayInYear rDayInYear: Int, year rYear: Int, hour: Int?, minute: Int?, second: Int?, nanosecond: Int?, options: FrenchRepublicanDateOptions) -> DateComponents {
        
        var gYear: Int
        var gDayOfYear: Int
        
        let gregorianCalendar = options.gregorianCalendar
        
        switch options.variant {
        case .original:
            gYear = rYear + 1792
            gDayOfYear = rDayInYear
            gDayOfYear.increment(by: -102, year: &gYear, daysInYear: \.daysInGregorianYear)
            
            var yt = 0
            var diff: Int
            repeat {
                diff = (gYear / 100 - 15) * 3 / 4 - 1 - yt
                gDayOfYear.increment(by: diff, year: &gYear, daysInYear: \.daysInGregorianYear)
                yt += diff
            } while diff != 0
            
            if options.variant.isYearSextil(rYear - 1) && !(gYear % 4 == 0 && !gYear.isBissextil) {
                gDayOfYear.increment(by: 1, year: &gYear, daysInYear: \.daysInGregorianYear)
            }
        case .romme:
            // hour: 10 avoids a timezone change issue on 1911-03-11 (9 minutes 21 seconds change) if we're on an autoupdating timezone (as is the case by default)
            let date = gregorianCalendar.date(from: DateComponents(year: rYear + 2000, day: rDayInYear, hour: 10))!
            let shifted = gregorianCalendar.date(byAdding: .day, value: -76071, to: date)!
            gYear = gregorianCalendar.component(.year, from: shifted)
            gDayOfYear = gregorianCalendar.ordinality(of: .day, in: .year, for: shifted)! - 1
            let remdays = (rYear - 1) / 4000
            gDayOfYear.increment(by: -remdays, year: &gYear, daysInYear: \.daysInGregorianYear)
        }
        
        return DateComponents(calendar: gregorianCalendar, year: gYear, day: gDayOfYear + 1, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
    }
}
