// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "YNExpandableCell",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "YNExpandableCell", targets: ["YNExpandableCell"])
    ],
    targets: [
        .target(
            name: "YNExpandableCell",
            path: "YNExpandableCell",
            exclude: [
                "YNExpandableCell.h",
                "Info.plist"
            ],
            resources: [
                .process("YNExpandableCell.xcassets")
            ],
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "YNExpandableCellTests",
            dependencies: ["YNExpandableCell"],
            path: "Tests/YNExpandableCellTests",
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        )
    ]
)
