// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "Minimo",
  defaultLocalization: "ja",
  platforms: [
    .iOS(.v18),
    .macOS(.v15),
  ],
  products: [
    .library(
      name: "Minimo",
      targets: ["Minimo"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/siteline/swiftui-introspect.git", from: "1.3.0"),
  ],
  targets: [
    .target(
      name: "Minimo",
      dependencies: [
        .product(name: "SwiftUIIntrospect", package: "swiftui-introspect"),
      ]
    ),
    .testTarget(
      name: "MinimoTests",
      dependencies: ["Minimo"]
    ),
  ]
)
