//
//  TransverseSearcherInteractor.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import Foundation

final class PokedexMainInteractor {
    
    // MARK: - Protocol properties
    
    weak var presenter: PokedexMainInteractorOutputProtocol?
    var remoteData: PokedexMainRemoteDataInputProtocol?
    
    // MARK: - Private properties
    private var pokemonList: [Pokemon] = []
}

extension PokedexMainInteractor: PokedexMainInteractorInputProtocol {
    func fetchPokemonBlock(_ urlString: String?) {
        remoteData?.requestPokemonBlock(urlString, handler: { [weak self] (result: (Result<PokemonBlock, Error>)) in
            switch result {
            case .success(let pokemonBlock):
                self?.presenter?.onReceivedData(with: pokemonBlock)
            case .failure(let error):
                print(error)
            }
            self?.presenter?.isFetchInProgress = false
        })
    }
    
    func fetchDetailFrom(pokemonName: String) {
        Dispatch
        remoteData?.requestPokemon(pokemonName, handler: { (result: Result<PokemonDetail, Error>) in
            switch result {
            case .success(let pokemon):
                self.handleSuccessfulDetailRequest(with: pokemon)
            case .failure(let failure):
                print("some error occured", failure)
            }
        })
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
    
    private func handleSuccessfulDetailRequest(with pokemon: PokemonDetail) {
        guard let imageData: Data = self.getImageDataFrom(urlString: pokemon.sprites.frontDefault)
        else { return }
        self.pokemonList.append(Pokemon(from: pokemon, imageData: imageData))
        self.presenter?.onReceivedPokemon(Pokemon(from: pokemon, imageData: imageData))
    }
}

extension PokedexMainInteractor: PokedexRemoteDataOutputProtocol {
    func handleService(error: NSError) {
        // TODO: Return data to presenter
        debugPrint("Returns data to presenter", error)
    }
}
