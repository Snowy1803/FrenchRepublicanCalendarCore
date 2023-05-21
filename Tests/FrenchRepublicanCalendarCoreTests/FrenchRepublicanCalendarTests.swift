//
//  FrenchRepublicanCalendarTests.swift
//  FrenchRepublicanCalendarCoreTests
//
//  Created by Emil Pedersen on 19/04/2020.
//  Copyright © 2020 Snowy_1803. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

@testable import FrenchRepublicanCalendarCore
import XCTest

class FrenchRepublicanCalendarTests: XCTestCase {
    
    override func setUp() {
        FrenchRepublicanDateOptions.current = .default
    }

    func testDateLinearity() throws {
        for variant in FrenchRepublicanDateOptions.Variant.allCases.reversed() {
            FrenchRepublicanDateOptions.current.variant = variant
            var date = FrenchRepublicanDate.origin
            var prevDay: Int?
            var prevYear: Int?
            while date <= FrenchRepublicanDate.maxSafeDate {
                let frd = FrenchRepublicanDate(date: date)
                
                if let prevDay = prevDay,
                   let prevYear = prevYear {
                    if frd.dayInYear == 1 {
                        XCTAssert(prevDay == (variant.isYearSextil(prevYear) ? 366 : 365), "Year ends after \(prevDay) days: \(frd.toLongString())")
                        XCTAssert(frd.components.year! - prevYear == 1, "Year wasn't incremented: \(frd.toLongString())")
                    } else {
                        XCTAssert(frd.dayInYear - prevDay == 1, "Invalid \(date) = \(frd.toLongString()) after \(FrenchRepublicanDate(dayInYear: prevDay, year: prevYear).toLongString())")
                        XCTAssert(frd.components.year! == prevYear, "Year changed without resetting day at \(frd.toLongString())")
                    }
                }
                
                prevDay = frd.dayInYear
                prevYear = frd.components.year!
                
                let copy = FrenchRepublicanDate(dayInYear: prevDay!, year: prevYear!, hour: frd.components.hour, minute: frd.components.minute, second: frd.components.second, nanosecond: frd.components.nanosecond)
                
                XCTAssert(copy.date == date, "Reconversion fails for \(date) = \(frd.toLongString()) ≠ \(copy.date)")
                
                date = Calendar.gregorian.date(byAdding: .day, value: 1, to: date)!
            }
            print("[Variant \(variant)] Tested until (Gregorian):", date)
        }
    }
    
    fileprivate func gregorianDate(era: Int, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, timeZone: TimeZone) -> Date {
        var dateComponents = DateComponents()
        dateComponents.era      = era
        dateComponents.year     = year
        dateComponents.month    = month
        dateComponents.day      = day
        dateComponents.timeZone = timeZone
        dateComponents.hour     = hour
        dateComponents.minute   = minute
        dateComponents.second   = second

        // Create date from components
        let userCalendar = Calendar(identifier: .gregorian) // since the components above (like year 1980) are for Gregorian
        return userCalendar.date(from: dateComponents)!
    }
    
    @available(iOS 10.0, *)
    fileprivate func testHistoricalDatesFor(_ timeZone: TimeZone?) {
//        debugPrint("################################################################################")
        let appropriateTimeZone: TimeZone = timeZone ?? TimeZone.current

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        df.timeZone = appropriateTimeZone
        
        let df2 = DateFormatter()
        df2.dateFormat = "yyyy-MM-dd\'T\'HH:mm:ss\'.000\'z"
        df2.timeZone = appropriateTimeZone
 
//        debugPrint(#file, #function, appropriateTimeZone.identifier, appropriateTimeZone.secondsFromGMT() / (60 * 60))
       
        let expectedOriginString = "01/01/1"
        // Testing 01/01/1 FRC:  Original
        let frcDateOrigin: Date = gregorianDate(era: 1, year: 1792, month: 9, day: 22, hour: 0, minute: 0, second: 0, timeZone: appropriateTimeZone)
            let frcDate: FrenchRepublicanDate = FrenchRepublicanDate(date: frcDateOrigin, options: .init(romanYear: false, variant: .original), timeZone: appropriateTimeZone)
//            debugPrint("• Variant:  Original")
//            debugPrint("• Origin:", frcDateOrigin)
//            debugPrint("• FRC date:", frcDate)
            XCTAssertEqual(frcDate.toShortenedString(), expectedOriginString)
        
        // Testing 01/01/1 FRC:  Romme
        let frcDateOrigin2: Date = gregorianDate(era: 1, year: 1792, month: 9, day: 22, hour: 0, minute: 0, second: 0, timeZone: appropriateTimeZone)
        let frcDate2: FrenchRepublicanDate = FrenchRepublicanDate(date: frcDateOrigin2, options: .init(romanYear: false, variant: .romme), timeZone: appropriateTimeZone)
//        debugPrint("• Variant:  Romme")
//        debugPrint("• Origin:", frcDateOrigin2)
//        debugPrint("• FRC date:", frcDate2)
        XCTAssertEqual(frcDate2.toShortenedString(), expectedOriginString)
        
        // Testing 18/02/8 FRC
        let expected9November1799String = "1799-11-09"
        let dateFor9November1799: Date = gregorianDate(era: 1, year: 1799, month: 11, day: 9, hour: 0, minute: 0, second: 0, timeZone: appropriateTimeZone)
        let frcFor9November1799: FrenchRepublicanDate = FrenchRepublicanDate(date: dateFor9November1799, timeZone: appropriateTimeZone)
        let frcFor9November1799String: String = frcFor9November1799.toShortenedString()
//        debugPrint("• 9 November 1799:", dateFor9November1799)
//        debugPrint("• FRC date for 9 November 1799:", frcFor9November1799)
//        debugPrint("• String for FRC date for 9 November 1799:", frcFor9November1799String)
        let stringFor18Brumaire8 = "18/02/8"
        XCTAssertEqual(frcFor9November1799String, stringFor18Brumaire8)
        let frcFor18Brumaire8: FrenchRepublicanDate = FrenchRepublicanDate(dayInYear: 48, year: 8, hour: 0, minute: 0, second: 0, nanosecond: 0, timeZone: appropriateTimeZone)
        let dateForFRCFor18Brumaire8: Date = frcFor18Brumaire8.date
        let stringForFRCFor18Brumaire8: String = df.string(from: dateForFRCFor18Brumaire8)
//        debugPrint("• FRC date for 18 Brumaire 8:", frcFor18Brumaire8)
//        debugPrint("• Date for 18 Brumaire 8:", dateForFRCFor18Brumaire8)
//        debugPrint("• String for date for 18 Brumaire 8:", stringForFRCFor18Brumaire8)
        XCTAssertEqual(stringForFRCFor18Brumaire8, expected9November1799String)
        
        // Testing 1970-01-01 CE
        let unixOriginAsString = "1970-01-01"
        let unixOrigin = gregorianDate(era: 1, year: 1970, month: 1, day: 1, hour: 0, minute: 0, second: 0, timeZone: appropriateTimeZone)
        let unixOriginOnFRC = FrenchRepublicanDate(date: unixOrigin, timeZone: appropriateTimeZone)
        let unixOriginOnFRCAsDate = unixOriginOnFRC.date
        XCTAssertEqual(df.string(from: unixOriginOnFRCAsDate), unixOriginAsString)
        
        let unixOriginOnFRC2 = FrenchRepublicanDate(dayInYear: (4 - 1) * 30 + 10, year: 178, hour: 0, minute: 0, second: 0, nanosecond: 0, timeZone: appropriateTimeZone)
        let unixOriginOnFRCAsDate2 = unixOriginOnFRC2.date
//        debugPrint("• Origin:", unixOriginOnFRCAsDate2)
//        debugPrint("• FRC date:", unixOriginOnFRC2)
//        debugPrint("• FRC date as ordinary date:", df2.string(from: unixOriginOnFRCAsDate2))
        let unixOriginOnFRCAsDate2AsString = df.string(from: unixOriginOnFRCAsDate2)
//        debugPrint("• FRC date string for comparison:", unixOriginOnFRCAsDate2AsString)
        XCTAssertEqual(unixOriginOnFRCAsDate2AsString, unixOriginAsString)

        // Testing 2022-08-08 CE, the day when the test was written
        let todayAsString = "2022-08-08"
        let today = gregorianDate(era: 1, year: 2022, month: 8, day: 8, hour: 0, minute: 0, second: 0, timeZone: appropriateTimeZone)
        let todayOnFRC = FrenchRepublicanDate(date: today)
        let todayOnFRCAsDate = todayOnFRC.date
        XCTAssertEqual(df.string(from: todayOnFRCAsDate), todayAsString)
    }
    
    @available(iOS 10.0, *)
    func testHistoricalDates() {
        testHistoricalDatesFor(nil)
    }
    
    @available(iOS 10.0, *)
    func testHistoricalDatesInTimeZones() {
        let Honolulu = TimeZone(identifier: "Pacific/Honolulu")! // -10
        testHistoricalDatesFor(Honolulu)

        let Anchorage = TimeZone(identifier: "America/Anchorage")! // -9
        testHistoricalDatesFor(Anchorage)

        let SaoPaulo = TimeZone(identifier: "America/Sao_Paulo")! // -3
        testHistoricalDatesFor(SaoPaulo)

        let Dublin = TimeZone(identifier: "Europe/Dublin")! // +0
        testHistoricalDatesFor(Dublin)

        let Paris = TimeZone(identifier: "Europe/Paris")! // +1
        testHistoricalDatesFor(Paris)

        let Bucharest = TimeZone(identifier: "Europe/Bucharest")! // +2
        testHistoricalDatesFor(Bucharest)

        let AddisAbaba = TimeZone(identifier: "Africa/Addis_Ababa")! // +3
        testHistoricalDatesFor(AddisAbaba)

        let Brunei = TimeZone(identifier: "Asia/Brunei")! // +8
        testHistoricalDatesFor(Brunei)

        let Tasmania = TimeZone(identifier: "Australia/Tasmania")! // +10
        testHistoricalDatesFor(Tasmania)

        let McMurdo = TimeZone(identifier: "Antarctica/McMurdo")! // +12
        testHistoricalDatesFor(McMurdo)
    }
    
    func testCurrentDate() throws {
        print(FrenchRepublicanDate(date: Date()))
        print(DecimalTime().debugDescription)
    }
    
    func testDayCount() throws {
        XCTAssert(FrenchRepublicanDate.allDayNames.count == 366)
    }
    
    func testWiktionnaryEntries() throws {
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        for i in FrenchRepublicanDate.allDayNames.indices {
            guard let url = FrenchRepublicanDate(dayInYear: i + 1, year: 1).descriptionURL else {
                XCTFail("invalid url for day #\(i): \(FrenchRepublicanDate.allDayNames[i])")
                return
            }
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else {
                    XCTFail("not http")
                    return
                }
                XCTAssertEqual(response.statusCode, 200, "Day \(i) not found")
                semaphore.signal()
            }
            task.resume()
            semaphore.wait()
        }
    }
    
    func testDecimalTime() throws {
        let min = DecimalTime(timeSinceMidnight: 0)
        XCTAssertEqual(min.description, "0:00:00")
        XCTAssertEqual(min.remainder, 0, accuracy: 1e-6)
        
        let max = DecimalTime(timeSinceMidnight: 86400 - DecimalTime.decimalSecond)
        XCTAssertEqual(max.description, "9:99:99")
        XCTAssertEqual(max.remainder, 0, accuracy: 1e-6)
        
        let mid = DecimalTime(timeSinceMidnight: 86400/2)
        XCTAssertEqual(mid.description, "5:00:00")
        XCTAssertEqual(mid.remainder, 0, accuracy: 1e-6)
        
        let rand = DecimalTime(timeSinceMidnight: DecimalTime.decimalSecond * 78427.2)
        XCTAssertEqual(rand.description, "7:84:27")
        XCTAssertEqual(rand.remainder, 0.2, accuracy: 1e-6)
        XCTAssertEqual(rand.decimalTime, 78427.2, accuracy: 1e-6)
        
        var edit = DecimalTime(timeSinceMidnight: 3601)
        XCTAssertEqual(edit.hourSI, 1)
        XCTAssertEqual(edit.minuteSI, 0)
        XCTAssertEqual(edit.secondSIPrecise, 1, accuracy: 1e-6)
        edit.minuteSI = 7
        XCTAssertEqual(edit.hourSI, 1)
        XCTAssertEqual(edit.minuteSI, 7)
        XCTAssertEqual(edit.secondSIPrecise, 1, accuracy: 1e-6)
        edit.hourSI = 3
        XCTAssertEqual(edit.hourSI, 3)
        XCTAssertEqual(edit.minuteSI, 7)
        XCTAssertEqual(edit.secondSIPrecise, 1, accuracy: 1e-6)
        edit.secondSI = 51
        XCTAssertEqual(edit.hourSI, 3)
        XCTAssertEqual(edit.minuteSI, 7)
        XCTAssertEqual(edit.secondSIPrecise, 51, accuracy: 1e-6)
    }
}

extension FrenchRepublicanDateOptions: SaveableFrenchRepublicanDateOptions {
    // permits changing the current options, doesn't save it anywhere, for testing
    public static var current: FrenchRepublicanDateOptions = .default
}
