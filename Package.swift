// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "Minimo",
  defaultLocalization: "ja",
  platforms: [
    .iOS(.v18),
  ],
  products: [
    .library(
      name: "Minimo",
      targets: ["Minimo"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/zunda-pixel/swiftui-introspect", branch: "add-UISheetPresentationController"),
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
