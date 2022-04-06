// swift-tools-version:5.5
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
