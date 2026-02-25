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
import Testing
import Foundation

@Suite("French Republican Calendar Tests")
struct FrenchRepublicanCalendarTests {
    @Test("Date linearity across all variants", arguments: FrenchRepublicanDateOptions.Variant.allCases)
    func dateLinearity(variant: FrenchRepublicanDateOptions.Variant) throws {
        var options = FrenchRepublicanDateOptions.current
        options.variant = variant
        var date = FrenchRepublicanDate.origin
        var prevDay: Int?
        var prevYear: Int?
        while date <= variant.maxSafeDate {
            let frd = FrenchRepublicanDate(date: date, options: options)
            
            if let prevDay = prevDay,
               let prevYear = prevYear {
                if frd.dayInYear == 1 {
                    #expect(prevDay == (variant.isYearSextil(prevYear) ? 366 : 365), "Year ends after \(prevDay) days: \(frd.toLongString())")
                    #expect(frd.components.year! - prevYear == 1, "Year wasn't incremented: \(frd.toLongString())")
                } else {
                    #expect(frd.dayInYear - prevDay == 1, "Invalid \(date) = \(frd.toLongString()) after \(FrenchRepublicanDate(dayInYear: prevDay, year: prevYear, options: options).toLongString())")
                    #expect(frd.components.year! == prevYear, "Year changed without resetting day at \(frd.toLongString())")
                }
            } else {
                #expect(frd.dayInYear == 1, "First date should be the 1st of the year: \(frd.toLongString())")
                #expect(frd.components.year! == 1, "First date should be in year 1: \(frd.toLongString())")
            }
            
            prevDay = frd.dayInYear
            prevYear = frd.components.year!
            
            let copy = FrenchRepublicanDate(dayInYear: prevDay!, year: prevYear!, time: frd.timeSinceMidnight, options: options)
            
            #expect(copy.date == date, "Reconversion fails for \(date) = \(frd.toLongString()) ≠ \(copy.date)")
            
            date = Calendar.gregorian.date(byAdding: .day, value: 1, to: date)!
        }
        print("[Variant \(variant)] Tested until (Gregorian):", date)
    }
    
    @available(iOS 10.0, *)
    @Test("Historical dates conversion")
    func historicalDates() {
        let df = ISO8601DateFormatter()
        df.formatOptions = .withFullDate
        for variant in FrenchRepublicanDateOptions.Variant.allCases {
            #expect(FrenchRepublicanDate(date: FrenchRepublicanDate.origin, options: .init(romanYear: false, variant: variant)).toShortenedString() == "01/01/1")
        }
        #expect(FrenchRepublicanDate(date: df.date(from: "1799-11-09")!).toShortenedString() == "18/02/8")
        #expect(df.string(from: FrenchRepublicanDate(dayInYear: 49, year: 8).date) == "1799-11-09")
    }
    
    @Test("Current date conversion")
    func currentDate() throws {
        print(FrenchRepublicanDate(date: Date()))
        print(DecimalTime().debugDescription)
    }
    
    @Test("Day count validation")
    func dayCount() throws {
        #expect(FrenchRepublicanDate.allDayNames.count == 366)
    }
    
    @Test("Wiktionary URL validation", .disabled("Disabled by default"))
    func wiktionaryEntries() throws {
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        for i in FrenchRepublicanDate.allDayNames.indices {
            guard let url = FrenchRepublicanDate(dayInYear: i + 1, year: 1).descriptionURL else {
                Issue.record("invalid url for day #\(i): \(FrenchRepublicanDate.allDayNames[i])")
                return
            }
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else {
                    Issue.record("not http")
                    return
                }
                #expect(response.statusCode == 200, "Day \(i) not found")
                semaphore.signal()
            }
            task.resume()
            semaphore.wait()
        }
    }
    
    @Test("Decimal time conversion and manipulation")
    func decimalTime() throws {
        let min = DecimalTime(timeSinceMidnight: 0)
        #expect(min.description == "0:00:00")
        #expect(abs(min.remainder - 0) < 1e-6)
        
        let max = DecimalTime(timeSinceMidnight: 86400 - DecimalTime.decimalSecond)
        #expect(max.description == "9:99:99")
        #expect(abs(max.remainder - 0) < 1e-6)
        
        let mid = DecimalTime(timeSinceMidnight: 86400/2)
        #expect(mid.description == "5:00:00")
        #expect(abs(mid.remainder - 0) < 1e-6)
        
        let rand = DecimalTime(timeSinceMidnight: DecimalTime.decimalSecond * 78427.2)
        #expect(rand.description == "7:84:27")
        #expect(abs(rand.remainder - 0.2) < 1e-6)
        #expect(abs(rand.decimalTime - 78427.2) < 1e-6)
        
        var edit = DecimalTime(timeSinceMidnight: 3601)
        #expect(edit.hourSI == 1)
        #expect(edit.minuteSI == 0)
        #expect(abs(edit.secondSIPrecise - 1) < 1e-6)
        edit.minuteSI = 7
        #expect(edit.hourSI == 1)
        #expect(edit.minuteSI == 7)
        #expect(abs(edit.secondSIPrecise - 1) < 1e-6)
        edit.hourSI = 3
        #expect(edit.hourSI == 3)
        #expect(edit.minuteSI == 7)
        #expect(abs(edit.secondSIPrecise - 1) < 1e-6)
        edit.secondSI = 51
        #expect(edit.hourSI == 3)
        #expect(edit.minuteSI == 7)
        #expect(abs(edit.secondSIPrecise - 51) < 1e-6)
    }
    
    @Test("Date formatter with various formats")
    func formatter() throws {
        let randomDate = FrenchRepublicanDate(date: .init(timeIntervalSince1970: 1762023488.74243))
        #expect(FRCFormat.short.format(randomDate) == "11 Brum.r")
        #expect(FRCFormat.dayMonth.format(randomDate) == "11 Brumaire")
        #expect(FRCFormat.long.format(randomDate) == "11 Brumaire An 234")
        #expect(FRCFormat.veryLong.format(randomDate) == "Primidi 11 Brumaire An 234")
        #expect(FRCFormat.veryLong.hour().minute().second().format(randomDate) == "Primidi 11 Brumaire An 234 à 8:32:04")
        #expect(FRCFormat().hour().minute().second().subsecond(.precision(3)).format(randomDate) == "8:32:04.563")
        #expect(FRCFormat().day(.dayName).format(randomDate) == "Salsifis")
        #expect(FRCFormat().hour().minute().second().subsecond(.precision(3)).useSI().format(randomDate) == "19:58:08.742")
    }
    
    @Test("Formatter with sansculottide dates")
    func formatterSansculottide() throws {
        let randomDate = FrenchRepublicanDate(date: .init(timeIntervalSince1970: 1758356624.1234))
        #expect(FRCFormat.short.format(randomDate) == "Jr opinion")
        #expect(FRCFormat.dayMonth.format(randomDate) == "Jour de l'opinion")
        #expect(FRCFormat.long.format(randomDate) == "Jour de l'opinion An 233")
        #expect(FRCFormat.veryLong.format(randomDate) == "Jour de l'opinion An 233")
        #expect(FRCFormat.veryLong.hour().minute().format(randomDate) == "Jour de l'opinion An 233 à 4:33")
        #expect(FRCFormat().day(.dayName).format(randomDate) == "Opinion")
    }
    
    @Test("Print All Delambre", .disabled("Disabled by default"))
    func printAllSansculottidesDelambre() {
        for year in 1...1210 {
            let p = "\(year) or \(FrenchRepublicanDate(dayInYear: 1, year: year, options: .init(romanYear: true, variant: .original)).formattedYear)"
            print(p, terminator: String(repeating: " ", count: 20 - p.count))
            let delambre = DelambreVariant()
            print(delambre.isYearSextil(year) ? "S" : " ", terminator: "\t")
            print("\(delambre.lookupConversion(year: year))/9/\(year + 1791)")
        }
    }
    
    @Test("Day explanations")
    func dayExplanations() {
        #expect(FrenchRepublicanDate(day: 7, month: 6, year: 1).dayName == "Alaterne")
        #expect(FrenchRepublicanDate(day: 7, month: 6, year: 1).dayNameExplanation == "Arbuste méditerranéen aux feuilles coriaces et aux baies noires appréciées des oiseaux")
        #expect(FrenchRepublicanDate(day: 6, month: 13, year: 3).dayName == "Révolution")
        #expect(FrenchRepublicanDate(day: 6, month: 13, year: 3).dayNameExplanation == "Fête ultime célébrée les années sextiles en l'honneur du renversement de la monarchie")
    }
}

extension FrenchRepublicanDateOptions: SaveableFrenchRepublicanDateOptions {
    // just changes the default time zone for the tests
    public static var current: FrenchRepublicanDateOptions {
        get {
            var value = Self.default
            value.timeZone = TimeZone(identifier: "Europe/Paris")
            return value
        }
        @available(*, deprecated, message: "Unsupported")
        set {}
    }
}
