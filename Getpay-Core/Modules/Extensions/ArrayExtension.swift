
// MARK: - Extension Array

public extension Array where Element: Hashable {
    func uniqueElements() -> [Element] {
        var seen = Set<Element>()
        
        return self.compactMap { element in
            guard !seen.contains(element)
            else { return nil }
            
            seen.insert(element)
            return element
        }
    }
    
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
