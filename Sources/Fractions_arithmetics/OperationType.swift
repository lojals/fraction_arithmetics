enum OperationType: String, CaseIterable {
    case add = "+"
    case substract = "-"
    case divide = "/"
    case multiply = "*"
    
    var execute: (Fraction, Fraction) -> Fraction {
        switch self {
        case .add: return { $0 + $1 }
        case .divide: return { $0 / $1 }
        case .multiply: return { $0 * $1 }
        case .substract:  return { $0 - $1 }
        }
    }
}
