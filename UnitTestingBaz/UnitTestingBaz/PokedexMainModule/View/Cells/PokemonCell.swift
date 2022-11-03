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

final class PokemonCell: UITableViewCell {
    
    // MARK: - Properties
    weak var delegate: PokemonCellDelegate?
    static var cellIdentifier: String = "PokemonCell"
    
    
    // MARK: - Private properties
    private var name: UILabel = UILabel()
    private var icon: UIImageView = UIImageView()
    private var innerContentView: UIView = UIView()
    private let cellHeight: CGFloat = 24
    private typealias Constants = PokedexMainConstants
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupName()
        setupIcon()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        return
    }
    
    // MARK: - Protocol methods
    func setup(with data: PokemonCellModel?) {
        guard let model: PokemonCellModel = data else {
            name.text = "Loading..."
            icon.image = UIImage(named: "pokemon_default")
            return
        }
        name.text = model.name
        icon.image = model.icon
    }
    
    // MARK: - Private functions
    
    private func setupLayout() {
        [innerContentView, name, icon].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        contentView.addSubview(innerContentView)
        contentView.addSubview(name)
        contentView.addSubview(icon)
        
        innerContentView.heightAnchor.constraint(equalToConstant: cellHeight).isActive = true
        
        NSLayoutConstraint.activate([
            innerContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.commonCellPadding),
            innerContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.commonCellPadding),
            innerContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.commonCellPadding),
            innerContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.commonCellPadding)
        ])
    }
    
    private func setupName() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor),
            name.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Constants.commonCellPadding),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.commonCellPadding)
        ])
        
        name.font = .systemFont(ofSize: 16)
        name.textColor = .gray
    }
    
    private func setupIcon() {
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: contentView.topAnchor),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            icon.widthAnchor.constraint(equalTo: icon.heightAnchor)
        ])
        icon.sizeToFit()
    }
}

