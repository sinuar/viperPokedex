//
//  SuggestedFieldCell.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import UIKit

protocol SuggestedFieldCellDelegate: AnyObject {
     func somethingTheCellShouldDo()
}

final class SuggestedFieldCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Properties
    weak var delegate: SuggestedFieldCellDelegate?
    static var cellIdentifier: String = "SuggestedFieldCell"
    
    
    // MARK: - Private properties
    private var icon: UIImageView = UIImageView()
    private var title: UILabel = UILabel()
    private var innerContentView: UIView = UIView()
    private typealias Constants = TransverseSearcherConstants
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupInnerContentView()
        setupIcon()
        setupTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        return
    }
    
    // MARK: - Protocol methods
    func setup(with data: CustomCellViewData) {
        guard let model: SuggestedFieldCellModel = data as? SuggestedFieldCellModel else { return }
        title.text = model.title
        icon.image = model.icon
    }
    
    // MARK: - Private functions
    
    private func setupLayout() {
        [icon, title, innerContentView].forEach({
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
    
    private func setupTitle() {
        innerContentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: innerContentView.topAnchor),
            title.leadingAnchor.constraint(equalTo: innerContentView.leadingAnchor, constant: Constants.commonCellPadding),
            title.bottomAnchor.constraint(equalTo: innerContentView.bottomAnchor),
            title.trailingAnchor.constraint(equalTo: innerContentView.trailingAnchor, constant: -Constants.commonCellPadding),
        ])
        
        title.font = .systemFont(ofSize: 16)
        title.textColor = .gray
    }
    
    private func setupIcon() {
        innerContentView.addSubview(icon)
        icon.sizeToFit()
        
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: innerContentView.leadingAnchor, constant: Constants.borderPadding),
            icon.centerYAnchor.constraint(equalTo: innerContentView.centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: Constants.suggestedFieldIconSize),
            icon.widthAnchor.constraint(equalToConstant: Constants.suggestedFieldIconSize)
        ])
    }
}

