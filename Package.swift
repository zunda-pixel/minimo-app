// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "Minimo",
  products: [
    .library(
      name: "Minimo",
      targets: ["Minimo"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/siteline/swiftui-introspect", from: "1.3.0"),
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
