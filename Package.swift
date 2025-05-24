// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Zipper",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Zipper",
            targets: ["ZipperPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "ZipperPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/ZipperPlugin"),
        .testTarget(
            name: "ZipperPluginTests",
            dependencies: ["ZipperPlugin"],
            path: "ios/Tests/ZipperPluginTests")
    ]
)