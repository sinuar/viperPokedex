//
//  PokedexProtocols.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import Foundation
import UIKit

// MARK: - VIPER protocols

// Presenter > Router
protocol PokedexMainRouterProtocol {
    func createTransverseSearcherModule() -> UINavigationController
    func popViewController(from view: PokedexMainViewControllerProtocol)
    func presentPokemonDetail(named pokemonName: String)
}

// View > Presenter
protocol PokedexMainViewControllerProtocol: AnyObject {
    var presenter: PokedexMainPresenterProtocol? { get set }
    
    var pokemonList: [PokemonCellModel] { get set }
    
    func reloadInformation()
    func fillPokemonList()
}

// Presenter > View
protocol PokedexMainPresenterProtocol: AnyObject {
    var view: PokedexMainViewControllerProtocol? { get set }
    var router: PokedexMainRouterProtocol? { get set }
    var model: [Pokemon] { get set }
    
    var totalPokemonCount: Int? { get set }
    
    func didSelectRowAt(_ indexPath: IndexPath)
    func shouldPrefetch(at indexPaths: [IndexPath])
    func isLoadingCell(for indexPath: IndexPath) -> Bool
    
    func reloadSections()
    func willPopController(from view: PokedexMainViewControllerProtocol)
    func willFetchPokemons()
}

// Interactor > Presenter
protocol PokedexMainInteractorInputProtocol {
    var presenter: PokedexMainInteractorOutputProtocol? { get set }
    var remoteData: PokedexMainRemoteDataInputProtocol? { get set }
    
    func fetchPokemonBlock(_ urlString: String?)
    func fetchDetailFrom(pokemonName: String)
}

extension PokedexMainInteractorInputProtocol {
    func fetchPokemonBlock(_ urlString: String? = nil) {
        fetchPokemonBlock(nil)
    }
}

// Presenter > Interactor
protocol PokedexMainInteractorOutputProtocol: AnyObject {
    var interactor: PokedexMainInteractorInputProtocol? { get set }
    
    var isFetchInProgress: Bool { get set }
    
    func onReceivedData(with pokemonBlock: PokemonBlock)
    func onReceivedPokemon(_ pokemons: Pokemon)
}

// Interactor > RemoteData
protocol PokedexMainRemoteDataInputProtocol {
    var interactor: PokedexRemoteDataOutputProtocol? { get set }
    
    func requestPokemonBlock(_ urlString: String?, handler: @escaping (Result<PokemonBlock, Error>) -> Void)
    func requestPokemon(_ name: String, handler: @escaping (Result<PokemonDetail, Error>) -> Void)
}

// RemoteData > Interactor
protocol PokedexRemoteDataOutputProtocol: AnyObject {
    func handleService(error: NSError)
}
