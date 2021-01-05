// swift-tools-version:5.0
import PackageDescription
let package = Package(
    name: "MailView",
    products: [
        .library(name: "MailView", targets: ["MailView"])
    ],
    targets: [
        .target(name: "MailView", path: "MailView")
    ]
)
