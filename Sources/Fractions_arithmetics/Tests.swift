import Foundation

struct Tests {
    func run () {
        runInstanceTests()
        runSimplifyTests()
        runCustomStringConvertibleStringTests()
        runOperationTests()
    }
    
    private func runInstanceTests() {
        print("\n INSTANCE TESTS")
        let instanceTests = [runInstanceTest(try! FractionParser.parse("20"), Fraction(numerator: 20, denominator: 1)),
                             runInstanceTest(try! FractionParser.parse("0"), Fraction(numerator: 0, denominator: 1)),
                             runInstanceTest(try! FractionParser.parse("-10"), Fraction(numerator: -10, denominator: 1)),
                             runInstanceTest(try! FractionParser.parse("20/2"), Fraction(numerator: 20, denominator: 2)),
                             runInstanceTest(try! FractionParser.parse("-20/2"), Fraction(numerator: -20, denominator: 2)),
                             runInstanceTest(try! FractionParser.parse("1_1/2"), Fraction(numerator: 3, denominator: 2)),
                             runInstanceTest(try! FractionParser.parse("-1_1/2"), Fraction(numerator: -3, denominator: 2))]
        
        instanceTests.forEach { print($0) }
    }
    
    private func runSimplifyTests() {
        print("\n SIMPLIFY TESTS")
        let simplifyTests = [runInstanceTest(try! FractionParser.parse("20/2").simplify(), Fraction(numerator: 10, denominator: 1)),
                             runInstanceTest(try! FractionParser.parse("-6/8").simplify(), Fraction(numerator: -3, denominator: 4)),
                             runInstanceTest(try! FractionParser.parse("-2_2/8").simplify(), Fraction(numerator: -9, denominator: 4)),
                             runInstanceTest(try! FractionParser.parse("2_2/8").simplify(), Fraction(numerator: 9, denominator: 4))]
        
        simplifyTests.forEach { print($0) }
    }
    
    private func runCustomStringConvertibleStringTests() {
        print("\n CUSTOM STRING CONVERTIBLE")
        let printTests = [runParseTest(try! FractionParser.parse("1").description, "1"),
                          runParseTest(try! FractionParser.parse("-5").description, "-5"),
                          runParseTest(try! FractionParser.parse("0").description, "0"),
                          runParseTest(try! FractionParser.parse("1/2").description, "1/2"),
                          runParseTest(try! FractionParser.parse("-1/2").description, "-1/2"),
                          runParseTest(try! FractionParser.parse("0/2").description, "0"),
                          runParseTest(try! FractionParser.parse("10/5").description, "2"),
                          runParseTest(try! FractionParser.parse("1_1/2").description, "1_1/2"),
                          runParseTest(try! FractionParser.parse("-1_1/2").description, "-1_1/2"),
                          runParseTest(try! FractionParser.parse("0_1/2").description, "1/2"),
                          runParseTest(try! FractionParser.parse("1_10/2").description, "6"),
                          runParseTest(try! FractionParser.parse("-1_10/2").description, "-6"),
                          runParseTest(try! FractionParser.parse("1_0/2").description, "1")]
        
        printTests.forEach { print($0) }
    }
    
    private func runOperationTests() {
        print("\n OPERATION TESTS")
        let operationTests = [runOperationTest("1/2 + 1/2", "1"),
                              runOperationTest("-1/2 + 1/2", "0"),
                              runOperationTest("1/2 + -1/2", "0"),
                              runOperationTest("1/3 + 1/3", "2/3"),
                              runOperationTest("1 + 3", "4"),
                              runOperationTest("20 + 3", "23"),
                              runOperationTest("1_1/2 + 1_1/2", "3"),
                              runOperationTest("1_1/3 + 1_1/3", "2_2/3"),
                              runOperationTest("1_1/3 + -1_1/3", "0"),
                              runOperationTest("2_1/3 - -1_1/3", "3_2/3"),
                              runOperationTest("2_1/3 - 1_1/3", "1"),
                              runOperationTest("2 - 1", "1"),
                              runOperationTest("1/3 - 1_1/3", "-1"),
                              runOperationTest("2_1/3 * -1_1/3", "-3_1/9"),
                              runOperationTest("2_1/3 * 1_1/3", "3_1/9"),
                              runOperationTest("2 * 1", "2"),
                              runOperationTest("1/3 * 1_1/3", "4/9"),
                              runOperationTest("2_1/3 / -1_1/3", "-1_3/4"),
                              runOperationTest("-2_1/3 / -1_1/3", "1_3/4"),
                              runOperationTest("2_1/3 / 1_1/3", "1_3/4"),
                              runOperationTest("2 / 1", "2"),
                              runOperationTest("1/3 / 1_1/3", "1/4")]
        
        operationTests.forEach { print($0) }
    }
    
}

extension Tests {
    private func runInstanceTest(_ input: Fraction, _ expectedOutput: Fraction) -> (Bool, String) {
        return assert(input, expectedOutput)
    }
    
    
    private func runParseTest(_ input: String, _ expectedOutput: String) -> (Bool, String) {
        guard let fraction = try? FractionParser.parse(input) else {
            return (false, "Syntax error")
        }
        return assert(fraction.description, expectedOutput)
    }
    
    private func runOperationTest(_ input: String, _ expectedOutput: String) -> (Bool, String) {
        guard let operationResult = try? ArithmeticsBrain.operate(input) else {
            return (false, "Syntax error")
        }
        return assert(operationResult.description, expectedOutput)
    }
    
    private func assert<T: Equatable & CustomStringConvertible>(_ input: T, _ expectedOutput: T) -> (Bool, String) {
        if input == expectedOutput {
            return (true, "✅")
        } else {
            return (false, "❌ \(input) != \(expectedOutput)")
        }
    }
}
