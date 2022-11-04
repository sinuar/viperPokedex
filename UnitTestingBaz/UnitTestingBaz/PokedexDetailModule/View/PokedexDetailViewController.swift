//
//  PokedexDetailViewController.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 01/11/22.
//

import UIKit

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

final class PokedexDetailViewController: UIViewController {
    
    // MARK: - Protocol properties
    
    var presenter: PokedexDetailPresenterProtocol?
    
    // MARK: - Private proeperties
    private typealias Constants = PokedexMainConstants
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupNavigationBar()
    }
    
    // MARK: - Private methods
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let appearance = UINavigationBarAppearance()
        let catImage = UIImage(named: "pokeball")?.imageResized(to: CGSize(width: 32, height: 32))
        catImage?.withRenderingMode(.alwaysTemplate)
        
        appearance.backgroundColor = UIColor.red
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: catImage, style: .plain, target: self, action: #selector(closeView))
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.title = "Pokémon"
    }
    
    
    @objc private func closeView() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PokedexDetailViewController: PokedexDetailViewControllerProtocol {
    
}
