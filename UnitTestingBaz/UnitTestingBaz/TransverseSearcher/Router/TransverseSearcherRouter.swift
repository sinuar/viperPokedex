//
//  TransverseSearcherRouter.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import UIKit

final class TransverseSearcherRouter {
    // MARK: - Properties
    var view: TransverseSearcherViewControllerProtocol?
    var interactor: (TransverseSearcherInteractorInputProtocol & TransverseSearcherRemoteDataOutputProtocol)?
    var presenter: (TransverseSearcherPresenterProtocol & TransverseSearcherInteractorOutputProtocol)?
    var router: TransverseSearcherRouterProtocol?
    var remoteData: TransverseSearcherRemoteDataInputProtocol?
}

extension TransverseSearcherRouter: TransverseSearcherRouterProtocol {
    
    func createTransverseSearcherModule() -> UINavigationController {
        buildModuleComponents()
        linkDependencies()
        guard let viewController: UIViewController = view as? UIViewController else {
            return UINavigationController()
        }
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    func popViewController(from view: TransverseSearcherViewControllerProtocol) {
        guard let viewController: UIViewController = view as? UIViewController else { return }
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func launchCategoryModule(with categoriesModel: [CategoryCellModel]) {
        guard let viewController: UIViewController = self.view as? UIViewController else { return }
        // Launch detail module
    }
    
    // MARK: - Private methods
    
    private func buildModuleComponents() {
        view = TransverseSearcherViewController()
        interactor = TransverseSearcherInteractor()
        presenter = TransverseSearcherPresenter()
        remoteData = TransverseSearcherRemoteDataManager()
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
