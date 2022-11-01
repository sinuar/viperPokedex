//
//  TransverseSearcherRemoteDataManager.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import Foundation

final class TransverseSearcherRemoteDataManager {
    // MARK: - Protocol properties
    weak var interactor: TransverseSearcherRemoteDataOutputProtocol?
}

extension TransverseSearcherRemoteDataManager: TransverseSearcherRemoteDataInputProtocol {
    
    
    
    func requestFromSearchBar(_ text: String, handler: @escaping (Result<PokemonList, Error>) -> Void) {
        let service: ServiceAPI = ServiceAPI(session: URLSession.shared)
        service.get(Endpoint.next(urlString: Endpoint.baseURL)) { data, error in
            
            guard let data: Data = data else {
                if let serviceError: Error = error {
                    handler(.failure(serviceError))
                }
                return
            }
            do {
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                handler(.success(pokemonList))
            } catch {
                handler(.failure(ServiceError.parsingData))
            }
        }
    }
    
    private var transverseSearcherEndpoint: String {
        // TODO: Check endpoint, it might change in the future
        return ""
    }
    
    private func getServiceState(with error: NSError) -> ServiceState {
        error.code == .zero ? .success : .failure
    }
    
    private enum ServiceState {
        case success
        case failure
    }
}
