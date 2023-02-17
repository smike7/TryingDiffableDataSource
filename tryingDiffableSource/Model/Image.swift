//
//  Image.swift
//  tryingDiffableSource
//
//  Created by Faisal on 17/02/2023.
//

import UIKit

protocol UnsplashModel where Self: Hashable & Equatable & Identifiable {
    associatedtype id: Equatable
    var id: id {get}
    var name: String {get set}
}

struct Image: UnsplashModel {
    let id = UUID()
    var name: String
    static let mockData: [Self] = [
        Image(name: "flowers"),
        Image(name: "lake"),
        Image(name: "lamp"),
        Image(name: "moreFlowers"),
        Image(name: "mountains"),
        Image(name: "parrot"),
        Image(name: "beach"),
        Image(name: "jungle"),
        Image(name: "desert"),
        Image(name: "bronco"),
    ]
}
