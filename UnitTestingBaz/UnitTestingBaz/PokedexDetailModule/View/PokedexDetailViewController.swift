//
//  PokedexDetailViewController.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 01/11/22.
//

import UIKit

final class PokedexDetailViewController: UIViewController {
    // MARK: - Protocol properties
    var presenter: PokedexDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}

extension PokedexDetailViewController: PokedexDetailViewControllerProtocol {
    
}
