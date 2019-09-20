import UIKit

struct Fraction {
    
    let numerator: Int
    let denominator: Int
    
    //whole_numerator/denominator
    init(from string: String) {
        //logic
        self.init(numerator: 0, denominator: 0)
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
    
    func simplify() -> Fraction {
        let _mcd = mcd(lhs: numerator, rhs: denominator)
        return Fraction(numerator: numerator/_mcd, denominator: denominator/_mcd)
    }
    
    static func + (lhs: Fraction, rhs: Fraction) -> Fraction {
        return Fraction(from: "0")
    }
}

let fraction = Fraction(numerator: 18, denominator: 21)
print(fraction.simplify())
