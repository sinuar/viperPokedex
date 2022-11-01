//
//  TransverseSearcherProtocols.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import Foundation
import UIKit

// MARK: - VIPER protocols

// Presenter > Router
protocol TransverseSearcherRouterProtocol {
    func createTransverseSearcherModule() -> UINavigationController
    func popViewController(from view: TransverseSearcherViewControllerProtocol)
    func launchCategoryModule(with categoriesModel: [CategoryCellModel])
}

// View > Presenter
protocol TransverseSearcherViewControllerProtocol: AnyObject {
    var presenter: TransverseSearcherPresenterProtocol? { get set }
    
    func reloadInformation()
}

// Presenter > View
protocol TransverseSearcherPresenterProtocol: AnyObject {
    var view: TransverseSearcherViewControllerProtocol? { get set }
    var router: TransverseSearcherRouterProtocol? { get set }
    var sections: [TransverseSearcherTableSection?] { get set }
    
    func reloadSections()
    func willPopController(from view: TransverseSearcherViewControllerProtocol)
    func willSearch(text: String)
    func save(lastSearch: String?)
}

// Interactor > Presenter
protocol TransverseSearcherInteractorInputProtocol {
    var presenter: TransverseSearcherInteractorOutputProtocol? { get set }
    var remoteData: TransverseSearcherRemoteDataInputProtocol? { get set }
    
    func search(_ text: String)
}

// Presenter > Interactor
protocol TransverseSearcherInteractorOutputProtocol: AnyObject {
    var interactor: TransverseSearcherInteractorInputProtocol? { get set }
    func onReceivedData(with categoriesModel: [CategoryCellModel])
}

// Interactor > RemoteData
protocol TransverseSearcherRemoteDataInputProtocol {
    var interactor: TransverseSearcherRemoteDataOutputProtocol? { get set }
    func requestFromSearchBar(_ text: String, handler: @escaping (Result<PokemonBlock, Error>) -> Void)
    func requestPokemon(id: String, handler: @escaping (Result<PokemonResult, Error>) -> Void)
}

// RemoteData > Interactor
protocol TransverseSearcherRemoteDataOutputProtocol: AnyObject {
    func handleService(error: NSError)
}

// MARK: - Functionality protocols

//protocol SuggestedFieldCellProtocol: UITableViewCell, ConfigurableCell, Reusable {
//
//}
