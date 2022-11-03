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
    private let dispatchGroup: DispatchGroup = DispatchGroup()
}

extension PokedexMainInteractor: PokedexMainInteractorInputProtocol {
    func fetchPokemonBlock(_ urlString: String?) {
        remoteData?.requestPokemonBlock(urlString, handler: { [weak self] (result: (Result<PokemonBlock, Error>)) in
            switch result {
            case .success(let pokemonBlock):
                self?.presenter?.onReceivedData(with: pokemonBlock)
                self?.handleSuccessfulBlockRequest()
            case .failure(let error):
                print(error)
            }
            self?.presenter?.isFetchInProgress = false
        })
    }
    
    func fetchDetailFrom(pokemonName: String) {
        dispatchGroup.enter()
        remoteData?.requestPokemon(pokemonName, handler: { (result: Result<PokemonDetail, Error>) in
            switch result {
            case .success(let pokemon):
                self.handleSuccessfulDetailRequest(with: pokemon)
            case .failure(let failure):
                print("some error occured", failure)
            }
        })
    }
    
//    let imageURL: URL = URL(string: pokemon.sprites.frontDefault) ?? URL(fileURLWithPath: "")
//    do {
//        let imageData: Data = try Data(contentsOf: imageURL)
//        self.pokemonList.append(Pokemon(from: pokemon, imageData: imageData))
//        self.dispatchGroup.leave()
//    } catch {
//        print("Hubo un error")
//    }
    
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
        self.dispatchGroup.leave()
    }
    
    private func handleSuccessfulBlockRequest() {
        self.dispatchGroup.notify(queue: DispatchQueue.global(qos: .userInteractive)) {
            let pokemons: [Pokemon] = self.pokemonList
            self.presenter?.onReceivedPokemons(pokemons)
        }
    }
}

extension PokedexMainInteractor: PokedexRemoteDataOutputProtocol {
    func handleService(error: NSError) {
        // TODO: Return data to presenter
        debugPrint("Returns data to presenter", error)
    }
}
