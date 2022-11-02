//
//  TransverseSearcherRemoteDataManager.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import Foundation

final class PokedexMainRemoteDataManager {
    // MARK: - Protocol properties
    weak var interactor: PokedexRemoteDataOutputProtocol?
}

extension PokedexMainRemoteDataManager: PokedexMainRemoteDataInputProtocol {
    
    func requestFromSearchBar(_ text: String, handler: @escaping (Result<PokemonBlock, Error>) -> Void) {
        let service: ServiceAPI = ServiceAPI(session: URLSession.shared)
        service.get(Endpoint.next(urlString: Endpoint.baseURL)) { [weak self] (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                self?.decodePokemonList(data: data, handler: handler)
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    func requestPokemon(id: String, handler: @escaping (Result<PokemonResult, Error>) -> Void) {
        let service: ServiceAPI = ServiceAPI(session: URLSession.shared)
        service.get(Endpoint.pokemon(nameOrId: id)) { [weak self] (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                self?.decodePokemon(data: data, handler: handler)
            case .failure(let error):
                print("error", error)
            }
        }
    }
 
    private func decodePokemonList(data: Data, handler: (Result<PokemonBlock, Error>) -> Void) {
        do {
            let pokemonList: PokemonBlock = try JSONDecoder().decode(PokemonBlock.self, from: data)
            handler(.success(pokemonList))
        } catch {
            handler(.failure(ServiceError.parsingData))
        }
    }
    
    private func decodePokemon(data: Data, handler: (Result<PokemonResult, Error>) -> Void) {
        do {
            let pokemon: PokemonResult = try JSONDecoder().decode(PokemonResult.self, from: data)
            handler(.success(pokemon))
        } catch {
            handler(.failure(ServiceError.parsingData))
        }
    }
}
