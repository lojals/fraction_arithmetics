import Foundation
import SPMUtility

func run() -> Int32 {
    let parser = ArgumentParser(usage: "Fractions_arithmetics COMMAND",
                                overview: "This is Fractions arithmetics")

    let operation = parser.add(option: "--operation", shortName: "-o", kind: String.self, usage: "Execute operation", completion: nil)
    let test = parser.add(option: "--test", shortName: "-t", kind: Bool.self, usage: "Run the tests", completion: nil)
    
    let arguments = Array(CommandLine.arguments.dropFirst())
    
    do {
        let result = try parser.parse(arguments)
        if let operation = result.get(operation) {
            let operationResult = try ArithmeticsBrain.operate(operation)
            print(operationResult)
        } else if result.get(test) != nil {
            Tests().run()
        }
     }
    catch {
        print(error)
        return 0
    }

    return 1
}

exit(run())
