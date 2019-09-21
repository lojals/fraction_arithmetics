import UIKit

struct Fraction {
    
    let numerator: Int
    let denominator: Int
    
    init(from string: String) {
        var whole: Int = 0
        var numerator: Int  = 0
        var denominator: Int = 0
        
        var cached: String = ""
        var signFlag: Bool =  false
        
        for s in string {
            switch s {
            case let x where x == "-":
                signFlag = true
            case let x where x.isNumber:
                cached.append(x)
            case let x where x == "_":
                whole = Int(cached) ?? 0
                cached = ""
            case let x where x == "/":
                numerator = Int(cached) ?? 0
                cached = ""
            default: break
            }
        }
        
        denominator = Int(cached) ?? 0
        if whole != 0 {
            numerator = numerator + whole * denominator
        }
        
        numerator = signFlag ? -numerator : numerator
        
        self.init(numerator: numerator, denominator: denominator)
    }
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    //maximo comun divisor segun euclides
    private func mcd(lhs: Int, rhs: Int) -> Int {
        let module = lhs % rhs
        return module == 0 ? rhs : mcd(lhs: rhs, rhs: module)
    }
    
    func simplify(lhs: Int, rhs: Int) -> Fraction {
        let _mcd = mcd(lhs: lhs, rhs: rhs)
        return Fraction(numerator: lhs/_mcd, denominator: rhs/_mcd)
    }
    
}

// MARK: - Arithmetics
extension Fraction {
    
    static func + (lhs: Fraction, rhs: Fraction) -> Fraction {
        let numerator = (lhs.numerator * rhs.denominator) + (lhs.denominator * rhs.numerator)
        let denominator = lhs.denominator * rhs.denominator
        return Fraction(numerator: numerator, denominator: denominator)
    }
    
    static func - (lhs: Fraction, rhs: Fraction) -> Fraction {
        let numerator = (lhs.numerator * rhs.denominator) - (lhs.denominator * rhs.numerator)
        let denominator = lhs.denominator * rhs.denominator
        return Fraction(numerator: numerator, denominator: denominator)
    }
    
    static func * (lhs: Fraction, rhs: Fraction) -> Fraction {
        let numerator = lhs.numerator * rhs.numerator
        let denominator = lhs.denominator * rhs.denominator
        return Fraction(numerator: numerator, denominator: denominator)
    }
    
    static func / (lhs: Fraction, rhs: Fraction) -> Fraction {
        let numerator = lhs.numerator * rhs.denominator
        let denominator = lhs.denominator * rhs.numerator
        return Fraction(numerator: numerator, denominator: denominator)
    }
    
}

extension Fraction: CustomStringConvertible {

    func properFraction() -> (Int, Int, Int) {
        if numerator <= denominator {
            let simplifiedFraction = simplify(lhs: numerator, rhs: denominator)
            return (0, simplifiedFraction.numerator, simplifiedFraction.denominator)
        } else {
            let whole = numerator/denominator
            let num1 = numerator - (whole * denominator)
            let simplifiedFraction = simplify(lhs: num1, rhs: denominator)
            return (whole, simplifiedFraction.numerator, simplifiedFraction.denominator)
        }
    }

    var description: String {
        return "\(properFraction())"
    }
}

enum OperationType: String {
    case add = "+"
    case substract = "-"
    case divide = "/"
    case multiply = "*"
    
    
    var xd: (Fraction, Fraction) -> Fraction {
        switch self {
        case .add: return { $0 + $1 }
        case .divide: return { $0 / $1 }
        case .multiply: return { $0 * $1 }
        case .substract:  return { $0 - $1 }
        }
    }
    
}

do {
    
    let oper = "-1/4 + 2_1/4 + 1/4 + 3/8 + 1"

    var result: Fraction?
    var pendingOperationType: OperationType?

    let allowedOperations = ["*", "/", "-", "+"]
    
    oper.components(separatedBy: " ").map { component in
        if allowedOperations.contains(component) {
            pendingOperationType = OperationType(rawValue: component) ?? .add
        } else {
            guard let op1 = result, let pendingOperationType = pendingOperationType else {
                result = Fraction(from: component)
                return
            }
            result = pendingOperationType.xd(op1, Fraction(from: component))
        }
    }
    
    print(result)
}

