// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "DCTar",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9),
        .macOS(.v10_10),
        .watchOS(.v2),
    ],
    products: [
        .library(
            name: "DCTar",
            targets: ["DCTar"]),
    ],
    targets: [
        .target(
            name: "DCTar",
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
            name: "DCTarTests",
            dependencies: [
                .target(name: "DCTar"),
            ],
            resources: [
                .copy("Resources/LICENSE"),
            ]
        ),
    ]
)
