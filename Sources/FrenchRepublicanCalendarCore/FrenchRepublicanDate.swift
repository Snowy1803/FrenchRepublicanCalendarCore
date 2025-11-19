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

public struct FrenchRepublicanDate: Hashable {
    
    // MARK: Static: Origin and Maximum
    
    /// The origin of the Republican Calendar, 1er Vendémiaire An 1 or 1792-09-22
    public static let origin = Date(timeIntervalSince1970: -5594191200)
    /// The maximum safe date to convert, currently 15300-12-31
    public static let maxSafeDate = FrenchRepublicanDateOptions.resolve(nil).variant.maxSafeDate
    /// The safe range that is guaranteed to convert properly
    public static let safeRange = origin...maxSafeDate
    
    // MARK: Instance variables
    
    /// the system Date value for this Republican Date
    public private(set) var date: Date
    
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
    public private(set) var components: DateComponents!
    
    public private(set) var options: FrenchRepublicanDateOptions
    
    // MARK: Component accessors
    
    /// The day in year date component, 1-indexed
    public var dayInYear: Int {
        (components.month! - 1) * 30 + components.day!
    }
    
    public var year: Int {
        components.year!
    }
    
    /// true if the current Republican year is sextil, false otherwise
    public var isYearSextil: Bool {
        options.variant.impl.isYearSextil(year)
    }
    
    /// The number of days in this year
    public var dayCountThisYear: Int {
        options.variant.impl.daysInYear(for: year)
    }
    
    public var isSansculottides: Bool {
        components.month == 13
    }
    
    public var timeSinceMidnight: TimeInterval {
        date.timeIntervalSince(options.gregorianCalendar.startOfDay(for: date))
    }
    
    public var decimalTime: DecimalTime {
        DecimalTime(timeSinceMidnight: timeSinceMidnight)
    }
    
    // MARK: Initializers
    
    /// Creates a Republican Date from the given Gregorian Date
    /// - Parameter date: the Gregorian Date
    public init(date: Date, options: FrenchRepublicanDateOptions? = nil) {
        self.date = date
        self.options = .resolve(options)
        let (dayOfYear, year) = self.options.variant.impl.convertToRepublican(gregorian: date, in: self.options.gregorianCalendar)
        initComponents(dayOfYear: dayOfYear, year: year)
    }
    
    /// Creates a Republican Date from Republican Date components. The `date` property will contain the Gregorian value, so this converts from Republican to Gregorian
    /// - Parameters:
    ///   - day: Day in Month, 1-indexed
    ///   - month: Month, 1-indexed
    ///   - year: The republican Year
    ///   - hour: Hour
    ///   - minute: Minutes
    ///   - second: Seconds
    ///   - nanosecond: Nanoseconds
    ///   - options: The options (variant, time zone) to use
    public init(day: Int, month: Int, year: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil, options: FrenchRepublicanDateOptions? = nil) {
        self.init(dayInYear: (month - 1) * 30 + day, year: year, hour: hour, minute: minute, second: second, nanosecond: nanosecond, options: options)
    }
    
    /// Creates a Republican Date from Republican Date components. The `date` property will contain the Gregorian value, so this converts from Republican to Gregorian
    /// - Parameters:
    ///   - day: Day in Month, 1-indexed
    ///   - month: Month, 1-indexed
    ///   - year: The republican Year
    ///   - time: Time in SI seconds since midnight
    ///   - options: The options (variant, time zone) to use
    public init(day: Int, month: Int, year: Int, time: TimeInterval, options: FrenchRepublicanDateOptions? = nil) {
        self.init(dayInYear: (month - 1) * 30 + day, year: year, time: time, options: options)
    }
    
    /// Creates a Republican Date from Republican Date components. The `date` property will contain the Gregorian value, so this converts from Republican to Gregorian
    /// - Parameters:
    ///   - dayInYear: Day in Year, 1-indexed
    ///   - year: The republican Year
    ///   - hour: Hour
    ///   - minute: Minutes
    ///   - second: Seconds
    ///   - nanosecond: Nanoseconds
    ///   - options: The options (variant, time zone) to use
    public init(dayInYear: Int, year: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil, options: FrenchRepublicanDateOptions? = nil) {
        let options: FrenchRepublicanDateOptions = .resolve(options)
        self.options = options
        
        let (dayInYear, year) = options.variant.impl.normalize(dayInYear: dayInYear, year: year)

        let (gDayOfYear, gYear) = options.variant.impl.convertToGregorian(rDayInYear: dayInYear, rYear: year, in: options.gregorianCalendar)
        self.date = options.gregorianCalendar.date(from: DateComponents(
            calendar: options.gregorianCalendar,
            timeZone: options.timeZone,
            year: gYear, day: gDayOfYear + 1,
            hour: hour, minute: minute, second: second, nanosecond: nanosecond
        ))!

        initComponents(dayOfYear: dayInYear - 1, year: year)
    }
    
    /// Creates a Republican Date from Republican Date components. The `date` property will contain the Gregorian value, so this converts from Republican to Gregorian
    /// - Parameters:
    ///   - dayInYear: Day in Year, 1-indexed
    ///   - year: The republican Year
    ///   - time: The time in the day, in SI seconds
    ///   - options: The options (variant, time zone) to use
    public init(dayInYear: Int, year: Int, time: TimeInterval, options: FrenchRepublicanDateOptions? = nil) {
        let options: FrenchRepublicanDateOptions = .resolve(options)
        self.options = options
        
        let (dayInYear, year) = options.variant.impl.normalize(dayInYear: dayInYear, year: year)

        let (gDayOfYear, gYear) = options.variant.impl.convertToGregorian(rDayInYear: dayInYear, rYear: year, in: options.gregorianCalendar)
        let dateComponents = DateComponents(calendar: options.gregorianCalendar, timeZone: options.timeZone, year: gYear, day: gDayOfYear + 1)
        self.date = options.gregorianCalendar.date(from: dateComponents)!.addingTimeInterval(time)

        initComponents(dayOfYear: dayInYear - 1, year: year)
    }
    
    /// Initializes the `components` property with the given values. The time used is the one in the gregorian `date`
    /// - Parameters:
    ///   - dayOfYear: Day of year, 0-indexed
    ///   - year: Year
    ///   - hour: Hour
    ///   - minute: Minutes
    ///   - second: Seconds
    ///   - nanosecond: Nanoseconds
    private mutating func initComponents(dayOfYear: Int, year: Int) {
        let timeComponents = options.gregorianCalendar.dateComponents([.hour, .minute, .second, .nanosecond], from: date)

        self.components = DateComponents(
            timeZone: options.timeZone,
            year: year,
            month: dayOfYear / 30 + 1,
            day: dayOfYear % 30 + 1,
            hour: timeComponents.hour!,
            minute: timeComponents.minute!,
            second: timeComponents.second!,
            nanosecond: timeComponents.nanosecond!,
            weekday: dayOfYear % 10 + 1,
            quarter: dayOfYear / 90 + 1,
            weekOfMonth: dayOfYear % 30 / 10 + 1,
            weekOfYear: dayOfYear / 10 + 1,
            yearForWeekOfYear: year
        )
    }
    
    // MARK: Utils
    
    /// Increments the Republican year for this Date. The Gregorian `date` will be recomputed.
    @available(*, deprecated, message: "Use `value = .init(dayInYear: value.dayInYear, year: value.year + 1)` directly instead")
    public mutating func nextYear() {
        self = .init(dayInYear: dayInYear, year: components.year! + 1, time: timeSinceMidnight, options: options)
    }
}
