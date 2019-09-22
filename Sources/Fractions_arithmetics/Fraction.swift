struct Fraction {
    
    let numerator: Int
    let denominator: Int
    
    init() {
        self.numerator = 0
        self.denominator = 1
    }
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    /// A function that calculetes the Greatest Common Divisor
    /// according euclidean algorithm.
    private func gcd(lhs: Int, rhs: Int) -> Int {
        let module = abs(lhs) % rhs
        return module == 0 ? rhs : gcd(lhs: rhs, rhs: module)
    }
    
    /// A function to reduce a fraction to lowest terms.
    ///
    /// - Returns: The reduced fraction.
    func simplify() -> Fraction {
        return simplify(numerator, denominator)
    }
    
    ///  A function to reduce a fraction to lowest terms.
    ///
    /// - Parameters:
    ///   - numerator: The numerator of the fraction.
    ///   - denominator: The denominator of the fraction.
    /// - Returns: The reduced fraction.
    func simplify(_ numerator: Int,_ denominator: Int) -> Fraction {
        let divisor = gcd(lhs: numerator, rhs: denominator)
        return Fraction(numerator: numerator/divisor, denominator: denominator/divisor)
    }
}

// MARK: - Arithmetics
extension Fraction {
    
    private func inverted() -> Fraction {
        return Fraction(numerator: denominator, denominator: numerator)
    }
    
    static func + (lhs: Fraction, rhs: Fraction) -> Fraction {
        return operate(+, lhs: lhs, rhs: rhs)
    }
    
    static func - (lhs: Fraction, rhs: Fraction) -> Fraction {
        return operate(-, lhs: lhs, rhs: rhs)
    }
    
    private static func operate(_ operation: (Int, Int) -> Int, lhs: Fraction, rhs: Fraction) -> Fraction {
        let numerator = operation(lhs.numerator * rhs.denominator, lhs.denominator * rhs.numerator)
        let denominator = lhs.denominator * rhs.denominator
        return Fraction(numerator: numerator, denominator: denominator)
    }
    
    static func * (lhs: Fraction, rhs: Fraction) -> Fraction {
        let numerator = lhs.numerator * rhs.numerator
        let denominator = lhs.denominator * rhs.denominator
        return Fraction(numerator: numerator, denominator: denominator)
    }
    
    static func / (lhs: Fraction, rhs: Fraction) -> Fraction {
        return lhs * rhs.inverted()
    }
    
}

// MARK: - CustomStringConvertible
extension Fraction: CustomStringConvertible {
    
    /// A function to convert an improper fraction into a mixed fraction.
    ///
    /// - Returns: A tuple containing, the whole, numerator and denominator.
    func properFraction() -> (whole: Int, fraction: Fraction) {
        let fraction: Fraction
        let whole: Int
        
        if abs(numerator) < denominator {
            whole = 0
            fraction = simplify(numerator, denominator)
        } else if numerator == denominator {
            whole = 1
            fraction = Fraction()
        } else {
            whole = numerator/denominator
            let reducedNumerator = numerator - (whole * denominator)
            fraction = simplify(abs(reducedNumerator), abs(denominator))
        }
        
        return (whole, fraction)
    }
    
    var description: String {
        let mixedFraction = properFraction()
        let whole = mixedFraction.whole
        let numerator = mixedFraction.fraction.numerator
        let denominator = mixedFraction.fraction.denominator
        
        if numerator == 0 {
            return "\(whole)"
        }
        
        if whole != 0 {
            return "\(whole)_\(numerator)/\(denominator)"
        } else {
            return "\(numerator)/\(denominator)"
        }
    }
}

// MARK: - Comparable
extension Fraction: Equatable {
    static func == (lhs: Fraction, rhs: Fraction) -> Bool {
        return lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
    }
}
