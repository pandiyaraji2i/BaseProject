//
//  DateExtensions.swift
//  Ideas2itStarter
//
//  Created by Pandiyaraj on 11/09/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import Foundation

public extension Date {
	/// Add calendar component to date.
	public mutating func add(_ component: Calendar.Component, value: Int) {
		switch component {
			
		case .second:
			self = calendar.date(byAdding: .second, value: value, to: self) ?? self
			break
			
		case .minute:
			self = calendar.date(byAdding: .minute, value: value, to: self) ?? self
			break
			
		case .hour:
			self = calendar.date(byAdding: .hour, value: value, to: self) ?? self
			break
			
		case .day:
			self = calendar.date(byAdding: .day, value: value, to: self) ?? self
			break
			
		case .weekOfYear, .weekOfMonth:
			self = calendar.date(byAdding: .day, value: value * 7, to: self) ?? self
			break
			
		case .month:
			self = calendar.date(byAdding: .month, value: value, to: self) ?? self
			break
			
		case .year:
			self = calendar.date(byAdding: .year, value: value, to: self) ?? self
			break
			
		default:
			break
		}
	}
	
	/// Return date by adding a component
	public func adding(_ component: Calendar.Component, value: Int) -> Date {
		switch component {
			
		case .second:
			return calendar.date(byAdding: .second, value: value, to: self) ?? self
			
		case .minute:
			return calendar.date(byAdding: .minute, value: value, to: self) ?? self
			
		case .hour:
			return calendar.date(byAdding: .hour, value: value, to: self) ?? self
			
		case .day:
			return calendar.date(byAdding: .day, value: value, to: self) ?? self
			
		case .weekOfYear, .weekOfMonth:
			return calendar.date(byAdding: .day, value: value * 7, to: self) ?? self
			
		case .month:
			return calendar.date(byAdding: .month, value: value, to: self) ?? self
			
		case .year:
			return calendar.date(byAdding: .year, value: value, to: self) ?? self
			
		default:
			return self
		}
	}
	
	/// Return date by changing a component
	public func changing(_ component: Calendar.Component, value: Int) -> Date {
		switch component {
			
		case .second:
			var date = self
			date.second = value
			return date
			
		case .minute:
			var date = self
			date.minute = value
			return date
			
		case .hour:
			var date = self
			date.hour = value
			return date
			
		case .day:
			var date = self
			date.day = value
			return date
			
		case .month:
			var date = self
			date.month = value
			return date
			
		case .year:
			var date = self
			date.year = value
			return date
			
		default:
			return self
		}
	}
	
	/// Return beginning of given date component.
	public func beginning(of component: Calendar.Component) -> Date? {
		
		switch component {
			
		case .second:
			return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self))
			
		case .minute:
			return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self))
			
		case .hour:
			return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour], from: self))
			
		case .day:
			return self.calendar.startOfDay(for: self)
			
		case .weekOfYear, .weekOfMonth:
			return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
			
		case .month:
			return calendar.date(from: calendar.dateComponents([.year, .month], from: self))
			
		case .year:
			return calendar.date(from: calendar.dateComponents([.year], from: self))
			
		default:
			return nil
		}
	}
	
	/// Return user’s current calendar.
	public var calendar: Calendar {
		return Calendar.current
	}
	
	/// Return date string from date
	func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = .none
		dateFormatter.dateStyle = style
		return dateFormatter.string(from: self)
	}
    
    
    func convertDateIntoSelectedFormat(format : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }
	

    
    /// Return date and time string from date
    func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    
    
    
    /// Return date string from date With Format
    func dateStringFromDate(toFormat:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = toFormat
//        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")! as TimeZone

        let dateString = dateFormatter.string(from: self)
        print("inputdate\(self)-->\(dateString)")
        return dateString
    }
    
	
	/// Day.
	public var day: Int {
		get {
			return calendar.component(.day, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: newValue, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
		}
	}
	
	/// Return date at the end of given date component.
	public func end(of component: Calendar.Component) -> Date? {
		
		switch component {
			
		case .second:
			var date = self.adding(.second, value: 1)
			guard let after = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)) else {
				return nil
			}
			date = after
			date.add(.second, value: -1)
			return date
			
		case .minute:
			var date = self.adding(.minute, value: 1)
			guard let after = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)) else {
				return nil
			}
			date = after.adding(.second, value: -1)
			return date
			
		case .hour:
			var date = self.adding(.hour, value: 1)
			guard let after = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour], from: self)) else {
				return nil
			}
			date = after.adding(.second, value: -1)
			return date
			
		case .day:
			var date = self.adding(.day, value: 1)
			date = date.calendar.startOfDay(for: date)
			date.add(.second, value: -1)
			return date
			
		case .weekOfYear, .weekOfMonth:
			var date = self
			guard let beginningOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else {
				return nil
			}
			date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
			return date
			
		case .month:
			var date = self.adding(.month, value: 1)
			guard let after = calendar.date(from: calendar.dateComponents([.year, .month], from: self)) else {
				return nil
			}
			date = after.adding(.second, value: -1)
			return date
			
		case .year:
			var date = self.adding(.year, value: 1)
			guard let after = calendar.date(from: calendar.dateComponents([.year], from: self)) else {
				return nil
			}
			date = after.adding(.second, value: -1)
			return date
			
		default:
			return nil
		}
	}
	
	/// Era.
	public var era: Int {
		return calendar.component(.era, from: self)
	}
	
	/// Hour.
	public var hour: Int {
		get {
			return calendar.component(.hour, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: newValue, minute: minute, second: second, nanosecond: nanosecond)
		}
	}
	
	/// Create a new date.
	public init(
		calendar: Calendar? = Calendar.current,
		timeZone: TimeZone? = TimeZone.current,
		era: Int? = Date().era,
		year: Int? = Date().year,
		month: Int? = Date().month,
		day: Int? = Date().day,
		hour: Int? = Date().hour,
		minute: Int? = Date().minute,
		second: Int? = Date().second,
		nanosecond: Int? = Date().nanosecond) {
		
		var components = DateComponents()
		components.calendar = calendar
		components.timeZone = timeZone
		components.era = era
		components.year = year
		components.month = month
		components.day = day
		components.hour = hour
		components.minute = minute
		components.second = second
		components.nanosecond = nanosecond
		
		self = calendar?.date(from: components) ?? Date()
	}
	
	/// Create date object from ISO8601 string (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
	public init(iso8601String: String) {
		// https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		self = dateFormatter.date(from: iso8601String) ?? Date()
	}
	
	/// Create new date object from UNIX timestamp.
	public init(unixTimestamp: Double) {
		self.init(timeIntervalSince1970: unixTimestamp)
	}
	
	/// Return true if date component in current given calendar component.
	public func isInCurrent(_ component: Calendar.Component) -> Bool {
		
		switch component {
		case .second:
			return second == Date().second && minute == Date().minute && hour == Date().hour && day == Date().day && month == Date().month && year == Date().year && era == Date().era
			
		case .minute:
			return minute == Date().minute && hour == Date().hour && day == Date().day && month == Date().month && year == Date().year && era == Date().era
			
		case .hour:
			return hour == Date().hour && day == Date().day && month == Date().month && year == Date().year && era == Date().era
			
		case .day:
			return day == Date().day && month == Date().month && year == Date().year && era == Date().era
			
		case .weekOfYear, .weekOfMonth:
			let beginningOfWeek = Date().beginning(of: .weekOfMonth)!
			let endOfWeek = Date().end(of: .weekOfMonth)!
			return self >= beginningOfWeek && self <= endOfWeek
			
		case .month:
			return month == Date().month && year == Date().year && era == Date().era
			
		case .year:
			return year == Date().year && era == Date().era
			
		case .era:
			return era == Date().era
			
		default:
			return false
		}
	}
	
	/// Return true if date is in future.
	public var isInFuture: Bool {
		return self > Date()
	}
	
	/// Return true if date is in past.
	public var isInPast: Bool {
		return self < Date()
	}
	
	/// Return true if date is in today.
	public var isInToday: Bool {
		return self.day == Date().day && self.month == Date().month && self.year == Date().year
	}
	
	/// Return ISO8601 string (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
	public var iso8601String: String {
		// https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
		
		return dateFormatter.string(from: self).appending("Z")
	}
	
	/// Minutes.
	public var minute: Int {
		get {
			return calendar.component(.minute, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: newValue, second: second, nanosecond: nanosecond)
		}
	}
	
	/// Month.
	public var month: Int {
		get {
			return calendar.component(.month, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: newValue, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
		}
	}
	
	/// Nanoseconds.
	public var nanosecond: Int {
		return calendar.component(.nanosecond, from: self)
	}
	
	/// Return nearest five minutes to date
	var nearestFiveMinutes: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		guard let min = components.minute else {
			return self
		}
		components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
		components.second = 0
		if min > 57 {
			components.hour? += 1
		}
		return Calendar.current.date(from: components) ?? Date()
	}
	
	/// Return nearest ten minutes to date
	var nearestTenMinutes: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		guard let min = components.minute else {
			return self
		}
		components.minute! = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
		components.second = 0
		if min > 55 {
			components.hour? += 1
		}
		return Calendar.current.date(from: components) ?? Date()
	}
	
	/// Return nearest quarter to date
	var nearestHourQuarter: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		guard let min = components.minute else {
			return self
		}
		components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
		components.second = 0
		if min > 52 {
			components.hour? += 1
		}
		return Calendar.current.date(from: components) ?? Date()
	}
	
	/// Return nearest half hour to date
	var nearestHalfHour: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		guard let min = components.minute else {
			return self
		}
		components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
		components.second = 0
		if min > 30 {
			components.hour? += 1
		}
		return Calendar.current.date(from: components) ?? Date()
	}
    
    var nearesMinutes: Date {
        var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
        guard let min = components.minute else {
            return self
        }
        components.second! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
        components.second = 0
        if min > 30 {
            components.hour? += 1
        }
        return Calendar.current.date(from: components) ?? Date()
    }
    
    public var getMarketClosedTime:Date {
        var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
        components.hour = 15
        components.minute = 30
        components.timeZone = NSTimeZone(name: "IST") as TimeZone?
        return Calendar.current.date(from: components)!

    }
    
    
	
	/// Quarter.
	public var quarter: Int {
		return calendar.component(.quarter, from: self)
	}
	
	/// Seconds.
	public var second: Int {
		get {
			return calendar.component(.second, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
		}
	}
	
	/// Return time string from date
	func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = style
		dateFormatter.dateStyle = .none
		return dateFormatter.string(from: self)
	}
    
//    func stringToDate(dateStr : String) -> Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let s = dateFormatter.date(from:dateStr)
//        return s!
//    }
    
    func getMonthfromDate(date: Date) -> String{
        let monthNumber = date.month
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.monthSymbols[monthNumber - 1]
    }
    
    func dateAtOnlyMonthandday() -> Date {
    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    
    //get the month/day/year componentsfor today's date.
    
    
    var date_components = calendar.components(
    [NSCalendar.Unit.year,
    NSCalendar.Unit.month,
    NSCalendar.Unit.day],
    from: self)
    
    date_components.timeZone = NSTimeZone(name: "IST") as TimeZone?
    //Create an NSDate for the specified time today.
    date_components.hour = 0
    date_components.minute = 0
    date_components.second = 0
    
    let newDate = calendar.date(from: date_components)!
    return newDate

    }
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
    
    func stringToDate(dateStr : String , format : String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let s = dateFormatter.date(from:dateStr)
        return s!
    }
    
    func xAxisFormat(dateStr : String , format : String = "yyyy-MM-dd HH:MM" , seconds : Int) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let s = dateFormatter.date(from:dateStr)
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        //get the month/day/year componentsfor today's date.
        
        
        var date_components = calendar.components(
            [NSCalendar.Unit.year,
             NSCalendar.Unit.month,
             NSCalendar.Unit.day],
            from: s!)
        
        //Create an NSDate for the specified time today.
        date_components.hour = s?.hour
        date_components.minute = s?.minute
        date_components.day = s?.day
        date_components.month = s?.month
        date_components.year = s?.year
        date_components.second = seconds
        
        let newDate = calendar.date(from: date_components)!
        return newDate
    }
	
	/// Return time zone used by system.
	public var timeZone: TimeZone {
		return self.calendar.timeZone
	}
	
	/// Get UNIX timestamp from date.
	var unixTimestamp: Double {
		return timeIntervalSince1970
	}
	
	/// Weekday.
	public var weekday: Int {
		return calendar.component(.weekday, from: self)
	}
	
	/// Week of month.
	public var weekOfMonth: Int {
		return calendar.component(.weekOfMonth, from: self)
	}
	
	/// Week of year.
	public var weekOfYear: Int {
		return calendar.component(.weekOfYear, from: self)
	}
	
	/// Year.
	public var year: Int {
		get {
			return calendar.component(.year, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: newValue, month: month, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
		}
	}
    
    public var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    
    public var last28Days : Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: self)!
    }
    
    public var previousMonth : Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
    public var previousYear : Date {
        return  Calendar.current.date(byAdding: .year, value: -1, to: self)!
    }
    
    public var nextMonth : Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }
    
    public var previousFiveMinutes : Date {
        return  Calendar.current.date(byAdding: .minute, value: -5, to: self)!
    }
    
    public var previousHour : Date {
        return  Calendar.current.date(byAdding: .hour, value: -1, to: self)!
    }
    
    public var currentDateStr : String {
        return self.dateStringFromDate(toFormat: "yyyy-MM-dd")
    }
    public var currentMonthStr : String {
        return self.dateStringFromDate(toFormat: "MMM").uppercased()
    }
    
    public var currentMonth : Int {
        return self.dateStringFromDate(toFormat: "MM").toInt!
    }
    
    public var currentYear : String{
        return self.dateStringFromDate(toFormat: "yy")
    }
    
    public var currentYearVal : Int{
        return self.dateStringFromDate(toFormat: "yyyy").toInt!
        
    }
    
    func dateAt(hours: Int, minutes: Int) -> Date
    {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        //get the month/day/year componentsfor today's date.
        
        
        var date_components = calendar.components(
            [NSCalendar.Unit.year,
             NSCalendar.Unit.month,
             NSCalendar.Unit.day],
            from: self)
        
        date_components.timeZone = NSTimeZone(name: "IST") as TimeZone?
        //Create an NSDate for the specified time today.
        date_components.hour = hours
        date_components.minute = minutes
        date_components.second = 0
        
        let newDate = calendar.date(from: date_components)!
        return newDate
    }
    
    func yearsBefore(last:Int) -> Date {
        return  Calendar.current.date(byAdding: .year, value: -(last), to: self)!
    }
    
    func convertDateFormaterOfDateString(_ date: String, inputFormat:String, outputFormat:String) -> String
    {
        let dateFormatter = DateFormatter()
        let timeZone = TimeZone(identifier: "UTC")
        let local = Locale.current
        dateFormatter.locale = local
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = inputFormat//"yyyy-MM-dd HH:mm:ss z"
        let dateStr = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = outputFormat//"yyyy-MM-dd"
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = local
        return  dateFormatter.string(from: dateStr!)

        
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func startOfWeek(weekday: Int?) -> Date {
        var cal = Calendar.current
        let component = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        cal.firstWeekday = weekday ?? 1
        return cal.date(from: component)!
    }
    
    func addNoOfDays(noOfDays:Int?) -> Date {
        let cal = Calendar.current
        var comps = DateComponents()
        comps.day = noOfDays
        return cal.date(byAdding: comps, to: self)!
    }
    
    func endOfWeek(weekday: Int) -> Date {
        let cal = Calendar.current
        var component = DateComponents()
        component.weekOfYear = 1
        component.day = -1
        return cal.date(byAdding: component, to: startOfWeek(weekday: weekday))!
    }
    var noOfWeeksInMonth : Int {
        let date = Date()
        let calendar = NSCalendar.current
        let range = calendar.range(of: .weekOfMonth, in: .month, for: date)
        let weeksCount = range?.count
        return weeksCount!
    }
    
    func dayRangeOf(weekOfMonth: Int, year: Int, month: Int) -> (Date ,Date)? {
        let calendar = Calendar.current
        guard let startOfMonth = calendar.date(from: DateComponents(year:year, month:month)) else { return nil }
        var startDate = Date()
        if weekOfMonth == 1 {
            var interval = TimeInterval()
            guard calendar.dateInterval(of: .weekOfMonth, start: &startDate, interval: &interval, for: startOfMonth) else { return nil }
        } else {
            let nextComponents = DateComponents(year: year, month: month, weekOfMonth: weekOfMonth)

            guard let weekStartDate = calendar.nextDate(after: startOfMonth, matching: nextComponents, matchingPolicy: .nextTime) else {
                return nil
            }
            startDate = weekStartDate
        }
        startDate = startDate.addNoOfDays(noOfDays: 1)
        let endComponents = DateComponents(day:7, second: -1)
        let endDate = calendar.date(byAdding: endComponents, to: startDate)!
        return (startDate ,endDate)
    }
    
    func dateAtBeginningOfDay() -> Date? {
        let calendar = NSCalendar.current
//        calendar.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        return calendar.startOfDay(for: self)

        
        // Selectively convert the date components (year, month, day) of the input date
        var dateComps = calendar.dateComponents([.year, .month, .day], from: self)
        // Set the time components manually
        dateComps.hour = 0
        dateComps.minute = 0
        dateComps.second = 0
        
        // Convert back
        let beginningOfDay = calendar.date(from: dateComps)
        return calendar.startOfDay(for: self)
    }
}
