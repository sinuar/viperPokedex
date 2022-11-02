//
//  TransverseSearcherViewController.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import UIKit

final class PokedexMainViewController: UIViewController {
    // MARK: - Protocol properties
    
    var presenter: PokedexMainPresenterProtocol?
    private typealias Constants = PokedexMainConstants
    
    // MARK: - Private properties
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.willFetchPokemons(text: "someText")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
        registerCells()
    }
    
    // MARK: - Private methods
    
    private func setupNavigationBar() {
        title = "Pokemon"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Constants.closeButtonIcon,
                                                            style: .plain, target: self,
                                                            action: #selector(closeView))
        navigationItem.rightBarButtonItem?.tintColor = Constants.purplueBarColor
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.borderPadding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.borderPadding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.borderPadding),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.borderPadding)
        ])
    }
    
    private func registerCells() {
        tableView.register(PokedexSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: PokedexSectionHeaderView.reuseIdentifier)
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.cellIdentifier)
    }
    
    @objc private func closeView() {
        presenter?.willPopController(from: self)
    }
}

extension PokedexMainViewController: PokedexMainViewControllerProtocol {
    func reloadInformation() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension PokedexMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        52
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView: PokedexSectionHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PokedexSectionHeaderView.reuseIdentifier) as? PokedexSectionHeaderView else { return nil }
        headerView.setup()
        return headerView
    }
}

extension PokedexMainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.model?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: PokemonCell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.cellIdentifier, for: indexPath) as? PokemonCell,
              let cellData: PokemonCellModel = presenter?.model?[indexPath.row]
        else { return UITableViewCell() }
        
        cell.setup(with: cellData)
        return cell
    }
    
    
}

extension PokedexMainViewController: PokemonCellDelegate {
    func somethingTheCellShouldDo() {
        print("The view launches a functionality that the cell can't do itself")
    }
}

