// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Bluetrum",
	platforms: [.iOS(.v15), .macOS(.v15), .visionOS(.v26)],
    products: [
        .library(name: "Bluetrum",targets: ["Bluetrum"]),
		.library(name: "FOTA", targets: ["FOTA"]),
		.library(name: "DeviceManager", targets: ["DeviceManager"]),
		.library(name: "Utils", targets: ["Utils"]),
    ],
	dependencies: [
		.package(url: "https://github.com/apple/swift-collections", branch: "main"),
	],
    targets: [
        .target(name: "Bluetrum"),
		.target(name: "FOTA", dependencies: [.target(name: "Utils"), .target(name: "DeviceManager")]),
		.target(name: "DeviceManager", dependencies: [.product(name: "Collections", package: "swift-collections"), .target(name: "Utils")]),
		.target(name: "Utils"),
        .testTarget(name: "BluetrumTests", dependencies: ["Bluetrum"]),
    ],
	swiftLanguageModes: [.v6]
)
