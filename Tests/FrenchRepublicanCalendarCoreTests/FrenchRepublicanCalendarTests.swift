//
//  FrenchRepublicanCalendarTests.swift
//  FrenchRepublicanCalendarTests
//
//  Created by Emil Pedersen on 19/04/2020.
//  Copyright © 2020 Snowy_1803. All rights reserved.
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
    
    @available(iOS 10.0, *)
    func testHistoricalDates() {
        let df = ISO8601DateFormatter()
        df.formatOptions = .withFullDate
        for variant in FrenchRepublicanDateOptions.Variant.allCases {
            XCTAssertEqual(FrenchRepublicanDate(date: FrenchRepublicanDate.origin, options: .init(romanYear: false, variant: variant)).toShortenedString(), "01/01/1")
        }
        XCTAssertEqual(FrenchRepublicanDate(date: df.date(from: "1799-11-09")!).toShortenedString(), "18/02/8")
        XCTAssertEqual(df.string(from: FrenchRepublicanDate(dayInYear: 49, year: 8).date), "1799-11-09")
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
    }
}

extension FrenchRepublicanDateOptions: SaveableFrenchRepublicanDateOptions {
    // permits changing the current options, doesn't save it anywhere, for testing
    public static var current: FrenchRepublicanDateOptions = .default
}
