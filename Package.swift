// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Fractions_arithmetics",
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.4.0")
    ],
    targets: [
        .target(
            name: "Fractions_arithmetics",
            dependencies: ["SPMUtility"])
    ]
)
