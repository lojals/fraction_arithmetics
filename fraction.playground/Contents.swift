import UIKit

struct Fraction {
    
    var value: String = ""
    
    let whole: Int
    let numerator: Int
    let denominator: Int
    
    //whole_numerator/denominator
    
    init(from string: String) {
        //logic
        self.init(numerator: 0, denominator: 0)
    }
    
    init(_ whole: Int = 0, numerator: Int, denominator: Int) {
        self.whole = whole
        self.numerator = numerator
        self.denominator = denominator
    }
    
    //maximo comun divisor segun euclides
    private func mcd(lhs: Int, rhs: Int) -> Int {
        let module = lhs % rhs
        if module == 0 {
            return rhs
        }
        return mcd(lhs: rhs, rhs: module)
    }
    
    func simplify() -> Fraction {
//        let _mcd = mcd(lhs: lhs, rhs: rhs)
//        return  (lhs/_mcd, rhs/_mcd)
        return Fraction(numerator: 0, denominator: 0)
    }
    
    
    static func + (lhs: Fraction, rhs: Fraction) -> Fraction {
        return Fraction(from: "0")
    }
}

//maximo comun divisor segun euclides
func mcd(lhs: Int, rhs: Int) -> Int {
    let module = lhs % rhs
    if module == 0 {
        return rhs
    }
    return mcd(lhs: rhs, rhs: module)
}

// convierte una fraccion impropia, en una propia simplificada
func properFraction(lhs: Int, rhs: Int) -> (Int, Int, Int) {
    if lhs <= rhs {
        return (0, lhs, rhs)
    } else {
        let unit = lhs/rhs
        let num1 = lhs - (unit * rhs)
        let simplifiedFraction = simplify(lhs: num1, rhs: rhs)
        return (unit, simplifiedFraction.0, simplifiedFraction.1)
    }
}

// simplifica una fraccion con el mcd
func simplify(lhs: Int, rhs: Int) -> (Int, Int) {
    let _mcd = mcd(lhs: lhs, rhs: rhs)
    return (lhs/_mcd, rhs/_mcd)
}



//print(simplify(lhs: 75, rhs: 25))

print(properFraction(lhs: 20, rhs: 6))


let fraction = Fraction(numerator: 20, denominator: 18)


