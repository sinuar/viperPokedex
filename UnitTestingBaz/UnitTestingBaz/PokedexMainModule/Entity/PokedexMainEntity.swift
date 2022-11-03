//
//  PokedexMainEntity.swift
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

struct PokemonCellModel: CustomCellViewData {
    var reuseIdentifier: String = "PokemonCell"
    let name: String?
    let icon: UIImage?
    
    init(from pokemon: Pokemon) {
        self.name = pokemon.name.capitalized
        self.icon = UIImage(data: pokemon.frontImageData)
    }
}


// MARK: - Pokeomon Block

struct PokemonBlock: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonBlockResult]?
}

// MARK: - Pokemon Result

struct PokemonBlockResult: Decodable {
    let name: String?
    let url: String?
}

struct PokemonDetail: Decodable {
    let name: String
    let sprites: PokemonSprites
}

struct PokemonSprites: Decodable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Pokemon {
    let name: String
    let frontImageData: Data
    
    init(from detail: PokemonDetail, imageData: Data) {
        self.name = detail.name
        self.frontImageData = imageData
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
