//
//  PokedexDetailProtocols.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 01/11/22.
//

import Foundation

protocol PokedexDetailRouterProtocol {
    
}

protocol PokedexDetailViewControllerProtocol: AnyObject {
    var presenter: PokedexDetailPresenterProtocol? { get set }
}

protocol PokedexDetailPresenterProtocol {
    var view: PokedexDetailViewControllerProtocol? { get set }
    var router: PokedexDetailRouterProtocol? { get set }
}

protocol PokedexDetailInteractorInputProtocol {
    var presenter: PokedexDetailInteractorOutputProtocol? { get set }
    var remoteData: PokedexDetailRemoteDataInputProtocol? { get set }
}

protocol PokedexDetailInteractorOutputProtocol: AnyObject {
    var interactor: PokedexDetailInteractorInputProtocol? { get set }
}

protocol PokedexDetailRemoteDataInputProtocol {
    var interactor: PokedexDetailRemoteDataOutputProtocol? { get set }
}

protocol PokedexDetailRemoteDataOutputProtocol {
    
}
