//
//  ProductCategories.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import Foundation

import UIKit

enum ProductCategory {
    case store
    case business
    case chat
    case news
    case entertainment
    case movies
}

// MARK: - Refactor for segregate logic

protocol ProductModelProtocol {
    var reuseIdentifier: String? { get set }
    var title: String? { get }
    var subtitles: [String]? { get }
    var imageData: Data? { get }
}

struct CommonProduct: ProductModelProtocol {
    var reuseIdentifier: String?
    var title: String?
    var subtitles: [String]?
    let imageData: Data?
}

struct StoreProduct: ProductModelProtocol {
    var reuseIdentifier: String?
    let title: String?
    let imageData: Data?
    let price: String?
    let subtitles: [String]?
}

struct ChatProduct: ProductModelProtocol {
    var reuseIdentifier: String?
    let title: String?
    let imageData: Data?
    let message: String?
    let subtitles: [String]?
}

struct MoviesProduct: ProductModelProtocol {
    var reuseIdentifier: String?
    let title: String?
    let imageData: Data?
    let subtitles: [String]?
    let price: String?
}
