import Foundation
import SPMUtility

func run() -> Int32 {
    let parser = ArgumentParser(usage: "--operation For executing a fraction operation",
                                overview: "This is Fractions arithmetics")

    let operation = parser.add(option: "--operation", shortName: "-o", kind: String.self, usage: nil, completion: nil)
    
    let arguments = Array(CommandLine.arguments.dropFirst())
    
    do {
        let result = try parser.parse(arguments)
        if let operation = result.get(operation) {
            print("🔥 \(operation)")
        }
    }
    catch {
        print(error)
        return 0
    }
    
    
    return 1
}

exit(run())
