import Foundation

public extension Date {
    var numberOfDaysFromToday: Int? {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day
    }
}

