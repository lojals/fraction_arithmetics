struct ArithmeticsBrain {
    
    /// This function executes an arithmetic operation based on an input string.
    ///
    /// - Parameter operationsString: An string representing an arithmetic operation.
    //    The input supports mixed fractions "1_1/3", whole numbers "2" and improper fractions "10/5"
    /// - Returns: The result of the operation simplified.
    /// - Throws: A `ParserError` if the string is in an invalid format.
    static func operate(_ operationsString: String) throws -> Fraction {
        var result: Fraction = Fraction()
        var pendingOperationType: OperationType?
        
        let inputComponents = operationsString.components(separatedBy: " ")
        
        if inputComponents.isEmpty {
            return try FractionParser.parse(operationsString)
        }
        
        try inputComponents.forEach { component in
            if let operation = OperationType(rawValue: component) {
                pendingOperationType = operation
            } else {
                guard let pendingOperationType = pendingOperationType else {
                    result = try FractionParser.parse(component)
                    return
                }
                result = pendingOperationType.execute(result, try FractionParser.parse(component))
            }
        }
        
        return result
    }
}
