import Foundation

public extension Date {
    var numberOfDaysFromToday: Int? {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day
    }
    
    var formatRangeDateService: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: self)
        return result
    }
    
    var formatDateDDMMYYYY: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: self)
        return result
    }
}

