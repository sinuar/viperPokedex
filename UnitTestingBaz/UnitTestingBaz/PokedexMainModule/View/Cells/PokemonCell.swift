//
//  PokemonCell.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import UIKit

protocol PokemonCellDelegate: AnyObject {
     func somethingTheCellShouldDo()
}

final class PokemonCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Properties
    weak var delegate: PokemonCellDelegate?
    static var cellIdentifier: String = "PokemonCell"
    
    
    // MARK: - Private properties
    private var name: UILabel = UILabel()
    private var innerContentView: UIView = UIView()
    private typealias Constants = PokedexMainConstants
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupInnerContentView()
        setupName()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        return
    }
    
    // MARK: - Protocol methods
    func setup(with data: CustomCellViewData) {
        guard let model: PokemonCellModel = data as? PokemonCellModel else { return }
        name.text = model.name
    }
    
    // MARK: - Private functions
    
    private func setupLayout() {
        [name, innerContentView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    private func setupInnerContentView() {
        contentView.addSubview(innerContentView)
        contentView.layer.borderWidth = .zero
        
        NSLayoutConstraint.activate([
            innerContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.commonCellPadding),
            innerContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.commonCellPadding),
            innerContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.commonCellPadding),
            innerContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.commonCellPadding)
        ])
//        ShadowStyler.setupCellShadow(view: innerContentView)
    }
    
    private func setupName() {
        innerContentView.addSubview(name)
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: innerContentView.topAnchor),
            name.leadingAnchor.constraint(equalTo: innerContentView.leadingAnchor, constant: Constants.commonCellPadding),
            name.bottomAnchor.constraint(equalTo: innerContentView.bottomAnchor),
            name.trailingAnchor.constraint(equalTo: innerContentView.trailingAnchor, constant: -Constants.commonCellPadding),
        ])
        
        name.font = .systemFont(ofSize: 16)
        name.textColor = .gray
    }
}

