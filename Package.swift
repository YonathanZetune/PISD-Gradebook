// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Gradebook" ,
    
    dependencies: [
        .Package(url: "https://github.com/tid-kijyun/Kanna.git", majorVersion: 2)
    ]
)
