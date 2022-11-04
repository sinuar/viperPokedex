//
//  PokedexMainConstants.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import UIKit

enum PokedexMainConstants {
    
    static let pokeballIcon: UIImage = UIImage(named: "pokeball") ?? UIImage()
    static let purplueBarColor: UIColor = .lightGray
    static func getIcon(_ iconName: IconName) -> UIImage {
        let image: UIImage = UIImage(named: iconName.rawValue) ?? UIImage()
        var imageWithTintColor: UIImage {
            switch iconName {
            case .bazCanal:
                return image
            case .payWithQR:
                return image.withTintColor(.yellow)
            case .games:
                return image.withTintColor(.purple)
            case .gifts:
                return image.withTintColor(.systemBlue)
            }
        }
        return imageWithTintColor
    }
    
    // MARK: - Common
    static let commonPadding: CGFloat = 8.0
    static let commonCornerRadius: CGFloat = 8.0
    static let commonCellBorderWidth: CGFloat = 0.05
    static let commonCellPadding: CGFloat = 4.0
    static let commonCellShadowOffset: CGSize = CGSize(width: .zero, height: 4)
    static let commonCellShadowOpacity: Float = 0.2
    static let commonCellShadowColor: CGColor = UIColor.gray.withAlphaComponent(1.0).cgColor
    static let commonCellShadowRadius: CGFloat = 2.5
    static let headerHeight: CGFloat = 48.0
    static let centerYHeaderHeightFactor = 0.7
    static let regularFontSize10: UIFont =  UIFont.systemFont(ofSize: 10)
    static let boldFontSize10: UIFont = UIFont.systemFont(ofSize: 10)
    static let regularPoppins12: UIFont = UIFont(name: "Poppins-Regular", size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
    static let regularPoppins10: UIFont = UIFont(name: "Poppins-Regular", size: 10.0) ??
    UIFont.systemFont(ofSize: 10.0)
    static let semiBoldPoppins20: UIFont = UIFont(name: "Poppins-SemiBold", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
    
    // MARK: - TransverseSearchField
    static let borderPadding: CGFloat = 16.0
    static let searchFieldBorderWidth: CGFloat = 0.5
    static let searchFieldTopPadding: CGFloat = 8.0
    static let searchFieldRightPadding: CGFloat = 64.0
    static let searchFieldHeight: CGFloat = 52.0
    static let searchIconSize: CGFloat = 24.0
    
    static func getClearIcon() -> UIImage {
        let clearIcon: UIImage = PokedexMainConstants.pokeballIcon.withRenderingMode(.alwaysTemplate)
        clearIcon.accessibilityIdentifier = "clearIcon"
        return clearIcon
    }
    
    static func getSearchIcon() -> UIImage {
        let searchIcon: UIImage = UIImage()
        searchIcon.accessibilityIdentifier = "searchIcon"
        return searchIcon
    }
    
    // MARK: - SuggestedFieldCell
    static let suggestedFieldIconSize: CGFloat = 24.0
    
    enum IconName: String {
        case bazCanal = "GSVCICICanalBaz"
        case payWithQR = "GSVCICScanOff"
        case games = "GSVCICVideoGameOn"
        case gifts = "GSVCICGiftsOff"
    }
}
