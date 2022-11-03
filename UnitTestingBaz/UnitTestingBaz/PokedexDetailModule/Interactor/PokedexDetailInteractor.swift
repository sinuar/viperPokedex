//
//  PokedexDetailInteractor.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 01/11/22.
//

import Foundation

final class PokedexDetailInteractor {
    
    // MARK: - Protocol properties
    
    weak var presenter: PokedexDetailInteractorOutputProtocol?
    var remoteData: PokedexDetailRemoteDataInputProtocol?
    
}

extension PokedexDetailInteractor: PokedexDetailInteractorInputProtocol {
    
    
}

extension PokedexDetailInteractor: PokedexDetailRemoteDataOutputProtocol {
    
}
