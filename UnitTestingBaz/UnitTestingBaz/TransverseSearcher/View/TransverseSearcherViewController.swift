//
//  TransverseSearcherViewController.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import UIKit

final class TransverseSearcherViewController: UIViewController {
    // MARK: - Protocol properties
    
    var presenter: TransverseSearcherPresenterProtocol?
    private typealias Constants = TransverseSearcherConstants
    
    // MARK: - Private properties
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.willSearch(text: "someText")
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
        tableView.register(SuggestedFieldCell.self, forCellReuseIdentifier: SuggestedFieldCell.cellIdentifier)
    }
    
    @objc private func closeView() {
        presenter?.willPopController(from: self)
    }
}

extension TransverseSearcherViewController: TransverseSearcherViewControllerProtocol {
    func reloadInformation() {
        print("reload")
    }
}

extension TransverseSearcherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
}

extension TransverseSearcherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.sections.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.sections[section]?.items.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentCellData: CustomCellViewData =  presenter?.sections[indexPath.section]?.items[indexPath.row],
              let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: currentCellData.reuseIdentifier) else {
                  let defaultCell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: SuggestedFieldCell.cellIdentifier)
                  return defaultCell
              }
        (cell as? ConfigurableCell)?.setup(with: currentCellData)
        (cell as? SuggestedFieldCell)?.delegate = self
        return cell
    }
    
    
}

extension TransverseSearcherViewController: SuggestedFieldCellDelegate {
    func somethingTheCellShouldDo() {
        print("The view launches a functionality that the cell can't do itself")
    }
}

