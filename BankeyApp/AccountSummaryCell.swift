//
//  AccountSummaryCell.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 31.05.2023.
//

import Foundation
import UIKit

enum AccountType: String, Codable {
    case Banking
    case CreditCard
    case Investment
}

final class AccountSummaryCell: UITableViewCell {
    
    
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let money: Decimal
        
        var moneyAsAtributedString: NSAttributedString{
            return  CurrencyFormatter().makeAttributedCurrency(money)
        }
    }
    private let viewModel: ViewModel? = nil
    
    
    private   let typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account type"
        return typeLabel
    }()
    
    private let underlineView:UIView = {
        let underlineView = UIView()
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = appColor
        return underlineView
    }()
    
    private  let nameLabel:UILabel = {
        let nameLabel =  UILabel()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.text = "Account name"
        
        return nameLabel
    }()
    
    private  let moneyStackView:UIStackView = {
        let moneyStackView = UIStackView()
        
        moneyStackView.translatesAutoresizingMaskIntoConstraints = false
        moneyStackView.axis = .vertical
        moneyStackView.spacing = 0
        
        return moneyStackView
    }()
    
    let moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        moneyLabel.font = UIFont.preferredFont(forTextStyle: .body)
        moneyLabel.textAlignment = .right
        moneyLabel.adjustsFontSizeToFitWidth = true
        moneyLabel.text = "Some balance"
        
        return moneyLabel
    }()
    let moneyAmountLabel: UILabel = {
        let moneyAmountLabel = UILabel()
        moneyAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        moneyAmountLabel.textAlignment = .right
        return moneyAmountLabel
    }()
    
    private let selectedImageView: UIImageView = {
        let selectedImageView = UIImageView()
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return selectedImageView
    }()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AccountSummaryCell {
    
    private func setup() {
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        
        moneyStackView.addArrangedSubview(moneyLabel)
        moneyStackView.addArrangedSubview(moneyAmountLabel)
        contentView.addSubview(moneyStackView)
        
        contentView.addSubview(selectedImageView)
        
        moneyAmountLabel.attributedText = makeFormattedMoney(dollars: "929,466", cents: "23")

        
        
      
        let chevronImage = UIImage(systemName: "chevron.right")!.withTintColor(appColor, renderingMode: .alwaysOriginal)
        selectedImageView.image = chevronImage
        
    }
    
    private func layout() {
        //typeLabel
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
        ])
        
        //underlineView
        NSLayoutConstraint.activate([
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineView.widthAnchor.constraint(equalTo: typeLabel.widthAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 4)
        ])
        //nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
        ])
        // stackView
        NSLayoutConstraint.activate([
            moneyStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            moneyStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: moneyStackView.trailingAnchor, multiplier: 4),
            
        ])
        //selectedImageView
        NSLayoutConstraint.activate([
            selectedImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: selectedImageView.trailingAnchor, multiplier: 1)
        ])
        
    }
}
// split and combine the mone func
extension AccountSummaryCell{
    private func makeFormattedMoney(dollars: String, cents: String)-> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}
extension AccountSummaryCell {
    func configure(with vm: ViewModel) {
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        moneyAmountLabel.attributedText = vm.moneyAsAtributedString
        
        switch vm.accountType {
        case .Banking:
            underlineView.backgroundColor = appColor
            moneyLabel.text = "Current balance"
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
            moneyLabel.text = "Current balance"
        case .Investment:
            underlineView.backgroundColor = .systemPurple
            moneyLabel.text = "Value"
        }
    }
}
