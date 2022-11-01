//
//  TransverseSearcherResultSections.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import UIKit

protocol CustomCellViewData {
    var reuseIdentifier: String { get }
}

protocol ConfigurableCell {
    func setup(with data: CustomCellViewData)
}

struct RecentlySearchedCellModel: CustomCellViewData {
    var reuseIdentifier: String = "RecentlySearchedCell"
    let title: String?
    var hasTopSeparator: Bool?
}

struct SuggestedFieldCellModel: CustomCellViewData {
    var reuseIdentifier: String = "SuggestedFieldCell"
    let title: String?
    let icon: UIImage
}

struct CategoryCellModel: CustomCellViewData {
    var reuseIdentifier: String = "CategoryCell"
    let title: String?
    let productType: ProductType?
    let productModel: ProductModelProtocol?
    let footer: String?
}

struct ProductCellModel: CustomCellViewData {
    var reuseIdentifier: String = "ProductCell"
    let title: String?
    let productType: ProductType?
    let productModel: ProductModelProtocol?
}

enum ProductType {
    case store
    case chat
    case movies
    case common
    
    var value: String {
        switch self {
        case .store:
            return "mistiendas"
        case .chat:
            return "mischats"
        case .movies:
            return "mispeliculas"
        case .common:
            return ""
        }
    }
}


struct TransverseSearcherTableSection {
    let title: String?
    let accesibilityIdentifier: String?
    let items: [CustomCellViewData]
}

// MARK: - Pokeomon List

struct PokemonBlock: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonResult]?
}

// MARK: - Pokemon Result

struct PokemonResult: Decodable {
    let name: String?
    let sprites: PokemonSprite?
    let url: String?
}

struct PokemonSprite: Decodable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Pokemon {
    let name: String
}

struct GetTransverseSearchResponse: Decodable {
    
    let message, folio: String?
    let result: SearchResult?
    
    enum CodingKeys: String, CodingKey {
        case message = "mensaje"
        case folio
        case result = "resultado"
    }
}

struct SearchResult: Decodable {
    let list: [SearchList]
    
    enum CodingKeys: String, CodingKey {
        case list = "listaRespuesta"
    }
}

struct SearchList: Decodable {
    let program: String?
    let response: SearchResponse?
    
    enum CodingKeys: String, CodingKey {
        case program = "programa"
        case response = "respuesta"
    }
}

struct SearchResponse: Decodable {
    let pagination: SearchPagination?
    let products: FilteredProducts?
    
    enum CodingKeys: String, CodingKey {
        case pagination = "paginacion"
        case products = "productos"
    }
}

struct SearchPagination: Decodable {
    let page: Int?
    let elementsPerPage: Int?
    let totalElements: Int?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page = "pagina"
        case elementsPerPage = "totalRegistrosPorPagina"
        case totalElements = "totalRegistros"
        case totalPages = "totalPaginas"
    }
}

struct FilteredProducts: Decodable {
    let found: FoundProducts
    
    enum CodingKeys: String, CodingKey {
        case found = "encontrados"
    }
}

struct FoundProducts: Decodable {
    let sku: String?
    let name: String?
    let categoryId: String?
    let category: String?
    let regularPrice: Double?
    let finalPrice: Double?
    let hasDiscount: Bool?
    let discountedPercentage: Double?
    let discountedPrice: Double?
    let hasFreeShipping: Bool?
    let shippingPrice: Double?
    let weeklyPayment: Double?
    let term: Double?
    let saleCreditAvailability: Bool?
    let urlImageString: String?
    
    enum CodingKeys: String, CodingKey {
        case sku
        case name = "nombre"
        case categoryId = "idCategoria"
        case category = "categoria"
        case regularPrice = "precioRegular"
        case finalPrice = "precioFinal"
        case hasDiscount = "descuento"
        case discountedPercentage = "porcentajeDescuento"
        case discountedPrice = "precioDescuento"
        case hasFreeShipping = "envioGratis"
        case shippingPrice = "montoEnvio"
        case weeklyPayment = "montoPagoSemanal"
        case term = "plazo"
        case saleCreditAvailability = "disponibleVentaCredito"
        case urlImageString = "urlImagenes"
    }
}

struct TransverseSearchRequest: Codable {
    let page: Int
    let filter: String
    
    enum CodingKeys: String, CodingKey {
        case page = "pagina"
        case filter = "filtro"
    }
}
