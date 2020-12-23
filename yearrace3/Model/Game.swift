//
//  Game.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/22/20.
//

import HorizonCalendar

import Foundation

enum Player {
    case user
    case computer
}

enum Mode {
    case getdec31
    case getjan1
}

enum Result : String {
    case ok = ""
    case invalid_bkwds = "You must pick a later date."
    case invalid_fwds = "You must pick an earlier date."
    case change_both = "You cannot change both the day and the month."
    case invalid_date = "This date does not exist."
}

//class Game {
//
//    var startDay: Day
//    var endDay: Day
//    var currentDay: Day
//    var lastChosenDay: Day
//
//    var whoMadeLastMove: Player!
//
//    init(mode: Mode) {
//        let startMonthInt = mode == .getdec31 ? 1 : 12
//        let startDayInt = mode == .getdec31 ? 1 : 31
//
//        let startDateComponents = DateComponents(year: 2020, month: startMonthInt, day: startDayInt)
//        let startDate = Calendar.current.date(from: startDateComponents)!
//        startDay = Calendar.current.day(containing: startDate)
//
//        let endMonthInt = mode == .getdec31 ? 12 : 1
//        let endDayInt = mode == .getdec31 ? 31 : 1
//
//        let endDateComponents = DateComponents(year: 2020, month: endMonthInt, day: endDayInt)
//        let endDate = Calendar.current.date(from: endDateComponents)!
//        endDay = Calendar.current.day(containing: endDate)
//
//        currentDay = startDay
//        lastChosenDay = startDay
//    }
//
//    func chooseDay(day: Day) -> Result {
//        guard isValidDay(day: day) == Result.ok else {
//            return isValidDay(day: day)
//        }
//
//        lastChosenDay = currentDay
//        currentDay = day
//        print("Current day is now: \(day)")
//        whoMadeLastMove = .user
//        return Result.ok
//    }
//
//    func isValidDay(day: Day) -> Result {return Result.ok}
//    func startGame() {
//        let firstDay = Int(arc4random_uniform(UInt32(27))) + 1
//        currentDay = Date(month: startDate.month, day: firstDay)
//        lastChosenDate = currentDate
//    }
//    func restart() { currentDate = startDate }
//    func makeMove() {}
//    func getNextPolePosition() -> Date {return Date(month: -1, day: -1)}
//    func checkForWinner() -> Player? {
//        return (currentDate == endDate) ? whoMadeLastMove : nil
//    }
//    func undo() {currentDate = lastChosenDate}
//}
//
//class GetDec31: Game {
//    init() {
//        super.init(mode: .getdec31)
//    }
//
//    override func isValidDate(date: Date) -> Result {
//        let changedBoth = date.month != currentDate.month && date.day != currentDate.day
//        let didNotAdvance = date <= currentDate
//        let maxDay = Calendar.maxDates[date.month - 1]
//        let pickedInvalid = date.day > maxDay
//
//        if didNotAdvance { return Result.invalid_bkwds }
//        else if changedBoth { return Result.change_both }
//        else if pickedInvalid { return Result.invalid_date }
//
//        return Result.ok
//    }
//
//
//    override func makeMove() {
//        // Pole position rule: day - month = 19
//        let poleSameMonth = Date(month: currentDate.month, day: currentDate.month + 19)
//        let poleSameDay = Date(month: currentDate.day - 19, day: currentDate.day)
//
//        if currentDate > poleSameMonth {
//            currentDate = poleSameDay
//        } else if currentDate == poleSameMonth{
//            currentDate = Date(month: poleSameMonth.month + 1, day: poleSameMonth.day)
//        } else {
//            currentDate = poleSameMonth
//        }
//
//        whoMadeLastMove = .computer
//    }
//
//    override func getNextPolePosition() -> Date {
//
//        // Pole position rule: day - month = 19
//        let poleSameMonth = Date(month: currentDate.month, day: currentDate.month + 19)
//        let poleSameDay = Date(month: currentDate.day - 19, day: currentDate.day)
//
//        if currentDate > poleSameMonth {
//            return poleSameDay
//        } else if currentDate == poleSameMonth{
//            return Date(month: poleSameMonth.month + 1, day: poleSameMonth.day + 1)
//        } else {
//            return poleSameMonth
//        }
//    }
//}
//
//class GetJan1: Game {
//    init() {
//        super.init(mode: .getjan1)
//    }
//
//    override func isValidDate(date: Date) -> Result {
//
//        let changedBoth = date.month != currentDate.month && date.day != currentDate.day
//        let wentFwds = date >= currentDate
//        let maxDay = Calendar.maxDates[date.month - 1]
//        let pickedInvalid = date.day > maxDay
//
//        if wentFwds { return Result.invalid_fwds }
//        else if changedBoth { return Result.change_both }
//        else if pickedInvalid { return Result.invalid_date }
//
//        return Result.ok
//    }
//
//    override func makeMove() {
//        // Pole position rule: day == month
//        let poleSameMonth = Date(month: currentDate.month, day: currentDate.month)
//        let poleSameDay = Date(month: currentDate.day, day: currentDate.day)
//
//        if currentDate > poleSameMonth {
//            currentDate = poleSameMonth
//        } else if currentDate == poleSameMonth{
//            currentDate = Date(month: poleSameMonth.month - 1, day: poleSameMonth.day)
//        } else {
//            currentDate = poleSameDay
//        }
//
//        whoMadeLastMove = .computer
//    }
//
//    override func getNextPolePosition() -> Date {
//        // Pole position rule: day == month
//        let poleSameMonth = Date(month: currentDate.month, day: currentDate.month)
//        let poleSameDay = Date(month: currentDate.day, day: currentDate.day)
//
//        if currentDate > poleSameMonth {
//            return poleSameMonth
//        } else if currentDate == poleSameMonth{
//            return Date(month: poleSameMonth.month - 1, day: poleSameMonth.day - 1)
//        } else {
//            return poleSameDay
//        }
//    }
//}

class Game {
    var startDate: Date
    var endDate: Date
    var currentDate: Date
    var lastChosenDate: Date

    var whoMadeLastMove: Player!
    
    init(mode: Mode) {
        let startMonthInt = mode == .getdec31 ? 1 : 12
        let startDayInt = mode == .getdec31 ? 1 : 31

        let startDateComponents = DateComponents(year: 2020, month: startMonthInt, day: startDayInt)
        startDate = Calendar.current.date(from: startDateComponents)!
//        startDay = Calendar.current.day(containing: startDate)

        let endMonthInt = mode == .getdec31 ? 12 : 1
        let endDayInt = mode == .getdec31 ? 31 : 1

        let endDateComponents = DateComponents(year: 2020, month: endMonthInt, day: endDayInt)
        endDate = Calendar.current.date(from: endDateComponents)!
//        endDay = Calendar.current.day(containing: endDate)

        currentDate = startDate
        lastChosenDate = startDate
    }
    
    func makeMove() {
        // Pole position rule: day - month = 19
        
//        let components = DateComponents(year: 2020, month: 07, day: 11)
//        let july2020 = Calendar.current.date(from: components)!
        
        let poleSameMonth = Calendar.current.month(containing: currentDate).month
        let day = Calendar.current.day(containing: currentDate)
        
        let poleSameMonth = Date(month: currentDate.month, day: currentDate.month + 19)
        let poleSameDay = Date(month: currentDate.day - 19, day: currentDate.day)
        
        if currentDate > poleSameMonth {
            currentDate = poleSameDay
        } else if currentDate == poleSameMonth{
            currentDate = Date(month: poleSameMonth.month + 1, day: poleSameMonth.day)
        } else {
            currentDate = poleSameMonth
        }
        
        whoMadeLastMove = .computer
    }
}
