import Foundation

// swiftlint:disable type_name
struct Package {
    let name: String
    let defaultLocalization: String
    let platforms: [Platform]
    let products: [Product]
    let dependencies: [Dependency]
    let targets: [Target]
}

enum Platform {
    case iOS(iOSVersion)
    // Add more platform types here if needed
    
    enum iOSVersion {
        case v15
        // Add more iOS versions here if needed
    }
}

enum Product {
    case library(name: String, targets: [String])
}

enum Dependency {
    case package(url: String, from: String)
}

enum Target {
    case target(
        name: String,
        dependencies: [String],
        path: String,
        plugins: [Plugin]
    )
    case testTarget(
        name: String,
        dependencies: [String],
        path: String,
        plugins: [Plugin]
    )
}

enum Plugin {
    case plugin(name: String, package: String)
}
// swiftlint:enable type_name
