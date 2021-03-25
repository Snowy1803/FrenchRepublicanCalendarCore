//
//  FrenchRepublicanCalendarCalculator.swift
//  FrenchRepublicanCalendar Shared
//
//  Created by Emil on 06/03/2020.
//  Copyright © 2020 Snowy_1803. All rights reserved.
//

import Foundation

struct FrenchRepublicanDate {
    
    // MARK: Static: Origin and Maximum
    
    /// The origin of the Republican Calendar, 1er Vendémiaire An 1 or 1792-09-22
    static let origin = Date(timeIntervalSince1970: -5594191200)
    /// The maximum safe date to convert, currently 15300-12-31
    static let maxSafeDate = Date(timeIntervalSinceReferenceDate: 419675853600) // 15299-12-31
    /// The safe range that is guaranteed to convert properly
    static let safeRange = origin...maxSafeDate
    
    // MARK: Instance variables
    
    /// the system Date value for this Republican Date
    var date: Date
    
    /// `year`: The year, starting at 1 for 1792-09-22,
    ///
    /// month: The month, 1-13 (13 being the additional days, called SANSCULOTTIDES),
    ///
    /// day: The day in the month 1-30 (1-5 or 1-6 for the 13th month, depending on .isYearSextil),
    ///
    /// hour, minute, second, nanosecond: The same as in the gregorian calendar,
    ///
    /// weekday: The weekday 1-10,
    ///
    /// quarter: The season, 1-5 (1=winter, 2=spring, 3=summer, 4=autumn, 5=SANSCULOTTIDES),
    ///
    /// weekOfMonth: The week within the month (a week being 10 days),
    ///
    /// weekOfYear: The week within the year (a week being 10 days)
    var components: DateComponents!
    
    var options: FrenchRepublicanDateOptions
    
    // MARK: Component accessors
    
    /// The day in year date component, 1-indexed
    var dayInYear: Int {
        return (components.month! - 1) * 30 + components.day!
    }
    
    /// true if the current Republican year is sextil, false otherwise
    var isYearSextil: Bool {
        return components.year!.isSextil
    }
    
    // MARK: Initializers
    
    /// Creates a Republican Date from the given Gregorian Date
    /// - Parameter date: the Gregorian Date
    init(date: Date) {
        self.date = date
        options = .current
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
    init(dayInYear: Int, year: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil) {
        self.date = Date(dayInYear: dayInYear, year: year, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
        options = .current
        initComponents(dayOfYear: dayInYear - 1, year: year, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
    }
    
    /// Logic that converts the `date` value to republican date components. Called by the Gregorian > Republican constructor
    private mutating func dateToFrenchRepublican() {
        let gregorian = Calendar.gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: date)
        let gYear = gregorian.year!
        
        var year = gYear - 1791
        var dayOfYear = Calendar.gregorian.ordinality(of: .day, in: .year, for: date)!
        dayOfYear.increment(by: -265, year: &year, daysInYear: \.daysInRepublicanYear)
        if gYear.isSextil {
            dayOfYear.increment(by: -1, year: &year, daysInYear: \.daysInRepublicanYear)
        }
        if (gYear).isBissextil {
            dayOfYear.increment(by: -1, year: &year, daysInYear: \.daysInRepublicanYear)
        }
        
        let remdays = (gYear / 100 - 15) * 3 / 4 - 1
        dayOfYear.increment(by: -remdays, year: &year, daysInYear: \.daysInRepublicanYear)
        
        initComponents(dayOfYear: dayOfYear, year: year, hour: gregorian.hour, minute: gregorian.minute, second: gregorian.second, nanosecond: gregorian.nanosecond)
    }
    
    /// Initializes the `components` property with the given values
    /// - Parameters:
    ///   - dayOfYear: Days of year, 0-indexed
    ///   - year: Year
    ///   - hour: Hour
    ///   - minute: Minutes
    ///   - second: Seconds
    ///   - nanosecond: Nanoseconds
    private mutating func initComponents(dayOfYear: Int, year: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil) {
        self.components = DateComponents(year: year, month: dayOfYear / 30 + 1, day: dayOfYear % 30 + 1, hour: hour, minute: minute, second: second, nanosecond: nanosecond, weekday: dayOfYear % 10 + 1, quarter: dayOfYear / 90 + 1, weekOfMonth: dayOfYear % 30 / 10 + 1, weekOfYear: dayOfYear / 10 + 1, yearForWeekOfYear: year)
    }
    
    // MARK: Mutating utils
    
    /// Increments the Republican year for this Date. The Gregorian `date` will be recomputed.
    mutating func nextYear() {
        components.year! += 1
        components.yearForWeekOfYear! += 1
        date = Date(dayInYear: dayInYear, year: components.year!, hour: components.hour, minute: components.minute, second: components.second, nanosecond: components.nanosecond)
    }
}

fileprivate extension Int {
    /// If self represents a republican year, this returns true if it is sextil
    var isSextil: Bool {
        return self % 4 == 3
    }
    
    /// If self represents a gregorian year, this returns true if it is bissextil
    var isBissextil: Bool {
        return ((self % 100 != 0) && (self % 4 == 0)) || self % 400 == 0
    }
    
    /// If self represents a republican year, this returns the number of days in it
    var daysInRepublicanYear: Int {
        isSextil ? 366 : 365
    }
    
    /// If self represents a gregorian year, this returns the number of days in it
    var daysInGregorianYear: Int {
        isBissextil ? 366 : 365
    }
    
    /// Increments the day component, and if it overflows, updates the year value
    /// - Parameters:
    ///   - add: The number of days to add (or remove if negative) to/from ourself
    ///   - year: The inout year, updated if necessary
    ///   - daysInYear: A keypath in Int returning an Int: "\.daysInRepublicanYear" or "\.daysInGregorianYear"
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

extension Calendar {
    static let gregorian: Calendar = {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = Locale(identifier: "fr-FR")
        return cal
    }()
}

extension Date {
    /// Creates a Date from the given Republican date components
    /// - Parameters:
    ///   - dayInYear: Republican Day in Year, 1-indexed
    ///   - year: Republican Year
    ///   - hour: Hour, will directly be copied over
    ///   - minute: Minute, will directly be copied over
    ///   - second: Second, will directly be copied over
    ///   - nanosecond: Nanosecond, will directly be copied over
    init(dayInYear: Int, year: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil) {
        self = Calendar.gregorian.date(from: Date.dateToGregorian(dayInYear: dayInYear, year: year, hour: hour, minute: minute, second: second, nanosecond: nanosecond))!
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
    static func dateToGregorian(dayInYear rDayInYear: Int, year rYear: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil) -> DateComponents {
        var gYear = rYear + 1792
        var gDayOfYear = rDayInYear
        gDayOfYear.increment(by: -102, year: &gYear, daysInYear: \.daysInGregorianYear)
        
        var yt = 0
        var diff: Int
        repeat {
            diff = (gYear / 100 - 15) * 3 / 4 - 1 - yt
            gDayOfYear.increment(by: diff, year: &gYear, daysInYear: \.daysInGregorianYear)
            yt += diff
        } while diff != 0
        
        if (rYear - 1).isSextil && !(gYear % 4 == 0 && !gYear.isBissextil) {
            gDayOfYear.increment(by: 1, year: &gYear, daysInYear: \.daysInGregorianYear)
        }
        
        return DateComponents(calendar: Calendar.gregorian, year: gYear, day: gDayOfYear + 1, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
    }
}
