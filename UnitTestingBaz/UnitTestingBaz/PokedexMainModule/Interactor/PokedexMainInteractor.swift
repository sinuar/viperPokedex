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
    var pokemonList: [Pokemon] = []
}

extension PokedexMainInteractor: PokedexMainInteractorInputProtocol {
    func search(_ text: String) {
        // TODO: Launch remote
        remoteData?.requestFromSearchBar(text, handler: { [weak self] (result: (Result<PokemonBlock, Error>)) in
            switch result {
            case .success(let pokemonBlock):
                guard let results: [PokemonResult] = pokemonBlock.results else { return }
                self?.presenter?.onReceivedData(with: results)
                
            case .failure(let error):
                print(error)
            }
        })
        
        print(pokemonList)
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

extension PokedexMainInteractor: PokedexRemoteDataOutputProtocol {
    func handleService(error: NSError) {
        // TODO: Return data to presenter
        debugPrint("Returns data to presenter", error)
    }
}
