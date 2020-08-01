//
//  Date+.swift
//  MicroInvestment
//
//  Created by Trung Hoang Van on 12/25/19.
//  Copyright © 2019 Funtap JSC. All rights reserved.
//

import Foundation

struct DateComponentUnitFormatter {
    
    private struct DateComponentUnitFormat {
        let unit: Calendar.Component
        
        let singularUnit: String
        let pluralUnit: String
        
        let futureSingular: String
        let pastSingular: String
    }
    
    private let formats: [DateComponentUnitFormat] = [
        
        DateComponentUnitFormat(unit: .year,
                                singularUnit: "năm",
                                pluralUnit: "năm",
                                futureSingular: "năm sau",
                                pastSingular: "1 năm trước"),
        
        DateComponentUnitFormat(unit: .month,
                                singularUnit: "tháng",
                                pluralUnit: "tháng",
                                futureSingular: "tháng sau",
                                pastSingular: "1 tháng trước"),
        
        DateComponentUnitFormat(unit: .weekOfYear,
                                singularUnit: "tuần",
                                pluralUnit: "tuần",
                                futureSingular: "tuần sau",
                                pastSingular: "1 tuần trước"),
        
        DateComponentUnitFormat(unit: .day,
                                singularUnit: "ngày",
                                pluralUnit: "ngày",
                                futureSingular: "ngày mai",
                                pastSingular: "1 ngày trước"),
        
        DateComponentUnitFormat(unit: .hour,
                                singularUnit: "giờ",
                                pluralUnit: "giờ",
                                futureSingular: "1 giờ trước",
                                pastSingular: "1 giờ trước"),
        
        DateComponentUnitFormat(unit: .minute,
                                singularUnit: "phút",
                                pluralUnit: "phút",
                                futureSingular: "1 phút trước",
                                pastSingular: "1 phút trước"),
        
        DateComponentUnitFormat(unit: .second,
                                singularUnit: "giây",
                                pluralUnit: "giây",
                                futureSingular: "Vừa xong",
                                pastSingular: "Vừa xong"),
        
        ]
    
    func string(forDateComponents dateComponents: DateComponents, useNumericDates: Bool) -> String {
        for format in self.formats {
            let unitValue: Int
            
            switch format.unit {
            case .year:
                unitValue = dateComponents.year ?? 0
            case .month:
                unitValue = dateComponents.month ?? 0
            case .weekOfYear:
                unitValue = dateComponents.weekOfYear ?? 0
            case .day:
                unitValue = dateComponents.day ?? 0
            case .hour:
                unitValue = dateComponents.hour ?? 0
            case .minute:
                unitValue = dateComponents.minute ?? 0
            case .second:
                unitValue = dateComponents.second ?? 0
            default:
                assertionFailure("Date does not have requried components")
                return ""
            }
            
            switch unitValue {
            case 2 ..< Int.max:
                return "\(unitValue) \(format.pluralUnit) trước"
            case 1:
                return useNumericDates ? "\(unitValue) \(format.singularUnit) trước" : format.pastSingular
            case -1:
                return useNumericDates ? "In \(-unitValue) \(format.singularUnit)" : format.futureSingular
            case Int.min ..< -1:
                return "\(-unitValue) \(format.pluralUnit) trước"
            default:
                break
            }
        }
        
        return "Vừa xong"
    }
}

extension Date {
    
    var day: Int {
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.dateComponents(Set<Calendar.Component>([.day]), from: self)
        return component.day ?? 0
    }
    
    var month: Int {
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.dateComponents(Set<Calendar.Component>([.month]), from: self)
        return component.month ?? 0
    }
    
    var year: Int {
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.dateComponents(Set<Calendar.Component>([.year]), from: self)
        return component.year ?? 0
    }
    
    var weekday: Int {
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.dateComponents(Set<Calendar.Component>([.weekday]), from: self)
        return component.weekday ?? 0
    }
    
    func toString(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let newDate = dateFormatter.string(from: self)
        
        return newDate
    }
    
    func toString(dateFormat: DateFormat? = .HHmmDDMMYYYY) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat?.rawValue
        //        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func toString(dateFormat: DateFormat? = .HHmmDDMMYYYY, locale: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.dateFormat = dateFormat?.rawValue
        //        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func toLocalTimeString(dateFormat: DateFormat = .HHmmDDMMYYYY) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: self)
    }
    
    func toLocalTimeString(dateFormat: DateFormat = .HHmmDDMMYYYY, locale: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: self)
    }
    
    func localTimeFormat(dateFormat: DateFormat? = .HHmmDDMMYYYY) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat?.rawValue
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
        
    }
    
    func timeAgoSinceNow(useNumericDates: Bool = false) -> String {
        
        let calendar = Calendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let components = calendar.dateComponents(unitFlags, from: self, to: now)
        
        let formatter = DateComponentUnitFormatter()
        return formatter.string(forDateComponents: components, useNumericDates: useNumericDates)
    }
}
