//
//  PokedexDetailPresenter.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 01/11/22.
//

import Foundation

final class PokedexDetailPresenter {
    
    // MARK: - Protocol properties
    weak var view: PokedexDetailViewControllerProtocol?
    var router: PokedexDetailRouterProtocol?
    var interactor: PokedexDetailInteractorInputProtocol?
    
}

extension PokedexDetailPresenter: PokedexDetailPresenterProtocol {
    
}

extension PokedexDetailPresenter: PokedexDetailInteractorOutputProtocol {
    
}
