//
//  TransverseSearcherInteractor.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import Foundation

final class TransverseSearcherInteractor {
    // MARK: - Protocol properties
    weak var presenter: TransverseSearcherInteractorOutputProtocol?
    var remoteData: TransverseSearcherRemoteDataInputProtocol?
}

extension TransverseSearcherInteractor: TransverseSearcherInteractorInputProtocol {
    func search(_ text: String) {
        // TODO: Launch remote
        remoteData?.requestFromSearchBar(text, handler: { [weak self] response in
            switch response {
            case .success(let pokemonList):
                print(pokemonList)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func getProductType(with program: String) -> ProductType {
        switch program {
        case ProductType.store.value:
            return .store
        case ProductType.chat.value:
            return .chat
        case ProductType.movies.value:
            return .movies
        default:
            return .common
        }
    }
    
    private func buildCategoryModel(with data: SearchList) -> CategoryCellModel {
        let productType: ProductType = getProductType(with: data.program ?? "")
        var categoryTitle: String
        var productModel: ProductModelProtocol
        switch productType {
        case .store:
            categoryTitle = "Tienda"
            productModel = getStoreModel(with: data)
        case .chat:
            categoryTitle = "Chat"
            productModel = getChatModel(with: data)
        case .movies:
            categoryTitle = "Películas"
            productModel = getMoviesModel(with: data)
        case .common:
            categoryTitle = "Celda común"
            productModel = CommonProduct(reuseIdentifier: "common_product", title: "Título del servicio", subtitles: ["título 1", "título 2"], imageData: nil)
        }
        return CategoryCellModel(title: categoryTitle, productType: productType, productModel: productModel, footer: "Ver más")
    }
    
    private func getStoreModel(with data: SearchList) -> StoreProduct {
        return StoreProduct(
            reuseIdentifier: "store_product",
            title: "Motocicleta café Racer Hero Xpulse 200T Negra",
            imageData: getImageDataFrom(urlString: "https://image.tmdb.org/t/p/w154/bvYjhsbxOBwpm8xLE5BhdA3a8CZ.jpg"),
            price: "4500",
            subtitles: ["semanales con baz crédito"])
    }
    
    private func getChatModel(with data: SearchList) -> ChatProduct {
        return ChatProduct(reuseIdentifier: "chat_product", title: "Chats", imageData: nil, message: "Podría ser subtitle", subtitles: ["Address", "9:00h a 14:00h"])
    }
    
    private func getMoviesModel(with data: SearchList) -> MoviesProduct {
        return MoviesProduct(
            reuseIdentifier: "movies_product",
            title: "Diarios de un motociclista",
            imageData: getImageDataFrom(urlString: "https://image.tmdb.org/t/p/w154/qz2aBYT8CAiJYvX4fRZpJ5G0Oz1.jpg"),
            subtitles: ["Address", "9:00h a 14:00h"], price: "500")
    }
    
    private func getImageDataFrom(urlString: String) -> Data? {
        guard let imageUrl: URL = URL(string: urlString) else {
            return nil
        }
        do {
            let imageData: Data = try Data(contentsOf: imageUrl)
            return imageData
        } catch {
            return nil
        }
    }
}

extension TransverseSearcherInteractor: TransverseSearcherRemoteDataOutputProtocol {
    func handleService(error: NSError) {
        // TODO: Return data to presenter
        debugPrint("Returns data to presenter", error)
    }
}
