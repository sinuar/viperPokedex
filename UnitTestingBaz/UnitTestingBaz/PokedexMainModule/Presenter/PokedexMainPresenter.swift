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
    
    var model: [Pokemon]?
    var isFetchInProgress: Bool = false
    var totalPokemonCount: Int?
    
    // MARK: - Private properties
    
    private typealias Constants = PokedexMainConstants
    private var nextBlockUrl: String?
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
    
    func willFetchPokemons() {
        interactor?.fetchPokemonBlock()
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
    
    func shouldPrefetch(at indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            guard !isFetchInProgress else { return }
            isFetchInProgress = true
            interactor?.fetchPokemonBlock(nextBlockUrl ?? "")
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let currentCount: Int = model?.count else { return false }
        let shouldFetchNextPokemonBlock: Bool = indexPath.row >= currentCount
//        debugPrint(indexPath.row)
//        debugPrint(shouldFetchNextPokemonBlock)
        return shouldFetchNextPokemonBlock
        
    }
}

extension PokedexMainPresenter: PokedexMainInteractorOutputProtocol {
    
    func onReceivedData(with pokemonBlock: PokemonBlock) {
        guard let pokemonResults: [PokemonBlockResult] = pokemonBlock.results else { return }
        self.nextBlockUrl = pokemonBlock.next
        self.totalPokemonCount = pokemonBlock.count
        for pokemon in pokemonResults {
            guard let pokemonName: String = pokemon.name else { return }
            interactor?.fetchDetailFrom(pokemonName: pokemonName)
        }
    }
    
    func onReceivedPokemons(_ pokemons: [Pokemon]) {
        self.model = pokemons
        view?.fillPokemonList()
    }
}
