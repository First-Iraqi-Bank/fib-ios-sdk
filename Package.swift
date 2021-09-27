// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FIBPaymentSDK",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "FIBPaymentSDK",
            targets: ["FIBPaymentSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "FIBPaymentSDK",
            path: "FIBPaymentSDK.xcframework")
    ])

