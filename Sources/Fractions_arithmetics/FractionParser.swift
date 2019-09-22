
import Foundation

struct FractionParser {
    
    /// A function that tries to parse an String into a Fraction instance.
    ///
    /// - Parameter fractionString: An string representing a Fraction.
    //    The input supports mixed fractions "1_1/3", whole numbers "2" and improper fractions "10/5"
    /// - Returns: A proper fraction.
    /// - Throws: A `ParserError` if the string is in an invalid format.
    static func parse(_ fractionString: String) throws -> Fraction  {
        try FractionParser.validate(fractionString)
        
        var whole: Int?
        var numerator: Int?
        var denominator: Int = 1
        
        var cached: String = ""
        var signFlag: Bool =  false

        for character in fractionString {
            switch character {
            case let character where character == "-":
                signFlag = true
            case let character where character.isNumber:
                cached.append(character)
            case let character where character == "_":
                whole = Int(cached) ?? 0
                cached = ""
            case let character where character == "/":
                numerator = Int(cached) ?? 0
                cached = ""
            default:
                throw ParserError.invalidFormat
            }
        }
        
        let cachedInt = Int(cached) ?? 0
        
        if numerator != nil {
            denominator = cachedInt
        } else if whole == nil {
            whole = cachedInt
        }
        
        var parsedNumerator: Int = numerator ?? 0
        
        if let whole = whole {
            parsedNumerator = parsedNumerator + whole * denominator
        }
        
        parsedNumerator = signFlag ? -parsedNumerator : parsedNumerator
        return Fraction(numerator: parsedNumerator, denominator: denominator)
    }
    
    private static func validate(_ string: String) throws {
        let regexString = "^-?\\d |(-?(?:\\d+_?)?(-?([1-9][0-9]*|0)\\/([1-9][0-9]*)))| -?\\d |-?\\d$"
        let regex = try NSRegularExpression(pattern: regexString, options: [])
        var isValid: Bool = false
        
        regex.enumerateMatches(in: string, options: [], range: NSRange(location: 0, length: string.count)) { (match, _, _) in
            isValid = match != nil ? true : false
        }
        
        if !isValid {
            throw ParserError.invalidFormat
        }
    }
}

enum ParserError: Error, CustomStringConvertible {
    case invalidFormat
    
    var description: String {
        switch self {
        case .invalidFormat: return "The string has an invalid format."
        }
    }
}
