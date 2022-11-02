//
//  TransverseSearcherPresenter.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import Foundation

final class PokedexMainPresenter {
    // MARK: - Protocol properties
    weak var view: PokedexMainViewControllerProtocol?
    var interactor: PokedexMainInteractorInputProtocol?
    var router: PokedexMainRouterProtocol?
    var model: [PokemonCellModel]?
    
    private typealias Constants = PokedexMainConstants
}

extension PokedexMainPresenter: PokedexMainPresenterProtocol {
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        guard let pokemonName: String = model?[indexPath.row].name else { return }
        router?.presentPokemonDetail(named: pokemonName)
        
    }
    
    func willPopController(from view: PokedexMainViewControllerProtocol) {
        router?.popViewController(from: view)
    }
    
    func reloadSections() {
        view?.reloadInformation()
    }
    
    func willFetchPokemons(text: String) {
        // TODO: Handle cases with special characters, white spaces or anything that could affect services response
        interactor?.search(text)
    }
    
    func save(lastSearch: String?) {
        guard let searchedValue: String = lastSearch else { return }
        let userDefaults: UserDefaults = UserDefaults.standard
        var recentSearches: [String] = userDefaults.object(forKey: "RecentSearches") as? [String] ?? []
        
        if recentSearches.count > 2 {
            recentSearches = recentSearches.dropLast()
        }
        guard searchedValue != recentSearches.first else { return }
        recentSearches.insert(searchedValue, at: .zero)
        UserDefaults.standard.set(recentSearches, forKey: "RecentSearches")
    }
}

extension PokedexMainPresenter: PokedexMainInteractorOutputProtocol {
    
    func onReceivedData(with pokemons: [PokemonResult]) {
        self.model = pokemons.map { (pokemon: PokemonResult) in
            PokemonCellModel(from: pokemon)
        }
        view?.reloadInformation()
    }
}
