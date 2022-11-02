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
    
    func reloadInformation()
}

// Presenter > View
protocol PokedexMainPresenterProtocol: AnyObject {
    var view: PokedexMainViewControllerProtocol? { get set }
    var router: PokedexMainRouterProtocol? { get set }
    var model: [PokemonCellModel]? { get set }
    
    func didSelectRowAt(_ indexPath: IndexPath)
    
    func reloadSections()
    func willPopController(from view: PokedexMainViewControllerProtocol)
    func willFetchPokemons(text: String)
    func save(lastSearch: String?)
}

// Interactor > Presenter
protocol PokedexMainInteractorInputProtocol {
    var presenter: PokedexMainInteractorOutputProtocol? { get set }
    var remoteData: PokedexMainRemoteDataInputProtocol? { get set }
    
    func search(_ text: String)
}

// Presenter > Interactor
protocol PokedexMainInteractorOutputProtocol: AnyObject {
    var interactor: PokedexMainInteractorInputProtocol? { get set }
    
    func onReceivedData(with pokemons: [PokemonResult])
}

// Interactor > RemoteData
protocol PokedexMainRemoteDataInputProtocol {
    var interactor: PokedexRemoteDataOutputProtocol? { get set }
    
    func requestFromSearchBar(_ text: String, handler: @escaping (Result<PokemonBlock, Error>) -> Void)
    func requestPokemon(id: String, handler: @escaping (Result<PokemonResult, Error>) -> Void)
}

// RemoteData > Interactor
protocol PokedexRemoteDataOutputProtocol: AnyObject {
    func handleService(error: NSError)
}

// MARK: - Functionality protocols

//protocol SuggestedFieldCellProtocol: UITableViewCell, ConfigurableCell, Reusable {
//
//}
