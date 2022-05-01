// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "TARKit",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9),
        .macOS(.v10_10),
        .watchOS(.v2),
    ],
    products: [
        .library(
            name: "TARKit",
            targets: ["TARKit"]),
    ],
    targets: [
        .target(
            name: "TARKit",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("DCTar"),
                .headerSearchPath("."),
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedLibrary("iconv")
            ]),
        .testTarget(
            name: "TARKitTests",
            dependencies: [
                .target(name: "TARKit"),
            ],
            resources: [
                .copy("Resources/LICENSE"),
                .copy("Resources/LICENSE.tar.gz"),
            ]
        ),
    ]
)
