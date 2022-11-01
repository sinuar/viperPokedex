//
//  TransverseSearcherPresenter.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import Foundation

final class TransverseSearcherPresenter {
    // MARK: - Protocol properties
    weak var view: TransverseSearcherViewControllerProtocol?
    var interactor: TransverseSearcherInteractorInputProtocol?
    var router: TransverseSearcherRouterProtocol?
    var model: [CategoryCellModel]?
    var sections: [TransverseSearcherTableSection?] = []
    
    private typealias Constants = TransverseSearcherConstants
    
    // MARK: - Private methods
    
    private func provide() -> [TransverseSearcherTableSection?] {
        let sections: [TransverseSearcherTableSection?] =
        [
            getSuggestedFieldSection()
        ]
        let notNilSections = sections.compactMap({ $0 })
        return notNilSections
    }
        
    private func getSuggestedFieldSection() -> TransverseSearcherTableSection {
        let items: [SuggestedFieldCellModel] = [
            SuggestedFieldCellModel(title: "Canal baz", icon: Constants.getIcon(.bazCanal)),
            SuggestedFieldCellModel(title: "Pagar con QR", icon: Constants.getIcon(.payWithQR)),
            SuggestedFieldCellModel(title: "Juegos", icon: Constants.getIcon(.games)),
            SuggestedFieldCellModel(title: "Tarjetas de regalo", icon: Constants.getIcon(.gifts))
        ]
        return TransverseSearcherTableSection(title: "Los más buscados", accesibilityIdentifier: "identificador_seccion_los_mas_buscados", items: items)
    }
}

extension TransverseSearcherPresenter: TransverseSearcherPresenterProtocol {
    func willPopController(from view: TransverseSearcherViewControllerProtocol) {
        router?.popViewController(from: view)
    }
    
    func reloadSections() {
        sections = provide()
        view?.reloadInformation()
    }
    
    func willSearch(text: String) {
        // TODO: Handle cases with special characters, white spaces or anything that could affect services response
        interactor?.search(text)
    }
    
    func save(lastSearch: String?) {
        guard let searchedValue: String = lastSearch else { return }
        let userDefaults: UserDefaults = UserDefaults.standard
        var recentSearches: [String] = userDefaults.object(forKey: "RecentSearches") as? [String] ?? []
        
        if recentSearches.count > 2 {
            recentSearches = recentSearches.dropLast()
        }
        guard searchedValue != recentSearches.first else { return }
        recentSearches.insert(searchedValue, at: .zero)
        UserDefaults.standard.set(recentSearches, forKey: "RecentSearches")
    }
}

extension TransverseSearcherPresenter: TransverseSearcherInteractorOutputProtocol {
    
    func onReceivedData(with categoriesModel: [CategoryCellModel]) {
        fillModel(with: categoriesModel)
        router?.launchCategoryModule(with: categoriesModel)
    }
    
    // MARK: - Private methods
    
    private func fillModel(with categoriesModel: [CategoryCellModel]) {
        self.model = categoriesModel
        sections = provide()
        view?.reloadInformation()
    }
}
