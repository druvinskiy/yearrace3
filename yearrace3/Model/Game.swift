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
    case change_both = "You cannot change both\n the day and the month."
    case invalid_date = "This date does not exist."
}

enum WonLostMessage: String {
    case won = "Well done. You win."
    case lost = "Sorry, you lost."
}

class Game: ObservableObject {

    var startDate: DateComponents
    var endDate: DateComponents
    var lastChosenDate: DateComponents
    fileprivate var whoMadeLastMove: Player
    var firstPlayer: Player
    var mode: Mode
    
    @Published var currentDate: DateComponents
    var winner: Player?
    
    static let defaultGame: Game = GetJan1(firstPlayer: .user)

    init(mode: Mode, firstPlayer: Player) {
        let startMonthInt = mode == .getdec31 ? 1 : 12
        let startDayInt = mode == .getdec31 ? 1 : 31
        startDate = DateComponents(month: startMonthInt, day: startDayInt)

        let endMonthInt = mode == .getdec31 ? 12 : 1
        let endDayInt = mode == .getdec31 ? 31 : 1
        endDate = DateComponents(month: endMonthInt, day: endDayInt)

        currentDate = startDate
        lastChosenDate = startDate
        
        self.firstPlayer = firstPlayer
        self.whoMadeLastMove = firstPlayer
        self.mode = mode
    }

    @discardableResult
    func chooseDate(_ date: DateComponents) -> Result {
        guard isValidDate(date: date) == Result.ok else {
            return isValidDate(date: date)
        }

        lastChosenDate = currentDate
        currentDate = date
        print("Current date is now: \(date)")
        whoMadeLastMove = .user
        
        checkForWinner()
        
        if winner == nil {
            makeMove()
        }
        
        return Result.ok
    }

    func isValidDate(date: DateComponents) -> Result {return Result.ok}
    func isValidDate(date: DateComponents) -> Bool { return isValidDate(date: date) == .ok }
    
    func startGame() {
        guard firstPlayer == .computer else { return }
        
        let firstDay = Int(arc4random_uniform(UInt32(27))) + 1
        currentDate = DateComponents(month: startDate.month, day: firstDay)
        lastChosenDate = currentDate
    }
    func restart() { currentDate = startDate }
    func makeMove() {}
    func getNextPolePosition() -> DateComponents {return DateComponents(month: -1, day: -1) }
    func checkForWinner() {
        winner = (currentDate == endDate) ? whoMadeLastMove : nil
    }
    func undo() {currentDate = lastChosenDate}
}

class GetDec31: Game {
    init(firstPlayer: Player) {
        super.init(mode: .getdec31, firstPlayer: firstPlayer)
    }

    override func isValidDate(date: DateComponents) -> Result {
        let changedBoth = date.month != currentDate.month && date.day != currentDate.day
        let didNotAdvance = date <= currentDate

        if didNotAdvance { return Result.invalid_bkwds }
        else if changedBoth { return Result.change_both }

        return Result.ok
    }
    
    private func generateRandomDate() -> DateComponents {
        let randomMonth = Int.random(in: currentDate.month!...12)
        let randomDay = Int.random(in: currentDate.day!...30)
        
        return DateComponents(month: randomMonth, day: randomDay)
    }
    
    override func makeMove() {
        // Pole position rule: day - month = 19
        let poleSameMonth = DateComponents(month: currentDate.month, day: currentDate.month! + 19)
        let poleSameDay = DateComponents(month: currentDate.day! - 19, day: currentDate.day)

        if currentDate > poleSameMonth {
            currentDate = poleSameDay
        } else if currentDate == poleSameMonth {
            var randomDate = generateRandomDate()
            
            while !isValidDate(date: randomDate) {
                randomDate = generateRandomDate()
            }
            
            currentDate = randomDate
            
//            currentDate = DateComponents(month: poleSameMonth.month! + 1, day: poleSameMonth.day)
        } else {
            currentDate = poleSameMonth
        }

        whoMadeLastMove = .computer
        
        checkForWinner()
    }

    override func getNextPolePosition() -> DateComponents {
        // Pole position rule: day - month = 19
        let poleSameMonth = DateComponents(month: currentDate.month, day: currentDate.month! + 19)
        let poleSameDay = DateComponents(month: currentDate.day! - 19, day: currentDate.day)

        if currentDate > poleSameMonth {
            return poleSameDay
        } else if currentDate == poleSameMonth{
            return DateComponents(month: poleSameMonth.month! + 1, day: poleSameMonth.day! + 1)
        } else {
            return poleSameMonth
        }
    }
}

class GetJan1: Game {
    init(firstPlayer: Player) {
        super.init(mode: .getjan1, firstPlayer: firstPlayer)
    }

    override func isValidDate(date: DateComponents) -> Result {

        let changedBoth = date.month != currentDate.month && date.day != currentDate.day
        let wentFwds = date >= currentDate

        if wentFwds { return Result.invalid_fwds }
        else if changedBoth { return Result.change_both }

        return Result.ok
    }
    
    private func generateRandomDate() -> DateComponents {
        let randomMonth = Int.random(in: 1...currentDate.month!)
        let randomDay = Int.random(in: 1...currentDate.day!)
        
        return DateComponents(month: randomMonth, day: randomDay)
    }

    override func makeMove() {
        // Pole position rule: day == month
        let poleSameMonth = DateComponents(month: currentDate.month!, day: currentDate.month!)
        let poleSameDay = DateComponents(month: currentDate.day!, day: currentDate.day!)

        if currentDate > poleSameMonth {
            currentDate = poleSameMonth
        } else if currentDate == poleSameMonth {
            var randomDate = generateRandomDate()
            
            while !isValidDate(date: randomDate) {
                randomDate = generateRandomDate()
            }
            
            currentDate = randomDate
            
//            currentDate = DateComponents(month: poleSameMonth.month! - 1, day: poleSameMonth.day)
        } else {
            currentDate = poleSameDay
        }

        whoMadeLastMove = .computer
        
        checkForWinner()
    }

    override func getNextPolePosition() -> DateComponents {
        // Pole position rule: day == month
        let poleSameMonth = DateComponents(month: currentDate.month, day: currentDate.month)
        let poleSameDay = DateComponents(month: currentDate.day, day: currentDate.day)

        if currentDate > poleSameMonth {
            return poleSameMonth
        } else if currentDate == poleSameMonth{
            return DateComponents(month: poleSameMonth.month! - 1, day: poleSameMonth.day! - 1)
        } else {
            return poleSameDay
        }
    }
}
