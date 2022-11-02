//
//  PokedexDetailRouter.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 01/11/22.
//

import UIKit

final class PokedexDetailRouter {
    // MARK: - Properties
    var view: PokedexDetailViewControllerProtocol?
    var interactor: (PokedexDetailInteractorInputProtocol & PokedexDetailRemoteDataOutputProtocol)?
    var presenter: (PokedexDetailPresenterProtocol & PokedexDetailInteractorOutputProtocol)?
    var router: PokedexDetailRouterProtocol?
    var remoteData: PokedexDetailRemoteDataInputProtocol?
}

extension PokedexDetailRouter: PokedexDetailRouterProtocol {
    
    func createPokedexDetailModule() -> UIViewController {
        buildModuleComponents()
        linkDependencies()
        guard let viewController: UIViewController = view as? UIViewController else {
            return UINavigationController()
        }
        return viewController
    }
    
    func popViewController(from view: PokedexDetailViewControllerProtocol) {
        guard let viewController: UIViewController = view as? UIViewController else { return }
        viewController.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private methods
    
    private func buildModuleComponents() {
        view = PokedexDetailViewController()
        interactor = PokedexDetailInteractor()
        presenter = PokedexDetailPresenter()
        remoteData = PokedexDetailRemoteDataManager()
        router = self
    }
    
    private func linkDependencies() {
        view?.presenter = self.presenter
        presenter?.view = self.view
        presenter?.interactor = self.interactor
        presenter?.router = self
        interactor?.remoteData = self.remoteData
        interactor?.presenter = self.presenter
        remoteData?.interactor = self.interactor
    }
}

