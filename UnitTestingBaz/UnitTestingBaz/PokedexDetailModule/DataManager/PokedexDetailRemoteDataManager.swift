//
//  PokedexDetailRemoteDataManager.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 01/11/22.
//

import Foundation

final class PokedexDetailRemoteDataManager {
    
    // MARK: - Protocol Properties
    var interactor: PokedexDetailRemoteDataOutputProtocol?
}

extension PokedexDetailRemoteDataManager: PokedexDetailRemoteDataInputProtocol {
    
    
}
