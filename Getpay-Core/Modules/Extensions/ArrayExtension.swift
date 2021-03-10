
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
}
