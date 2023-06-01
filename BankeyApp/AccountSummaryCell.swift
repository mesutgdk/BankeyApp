//
//  AccountSummaryCell.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 31.05.2023.
//

import Foundation
import UIKit

class AccountSummaryCell: UITableViewCell {
    
    enum AccountType: String {
        case Banking
        case CreditCard
        case Investment
    }
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
//        let balance: Decimal
//
//        var balanceAsAtributedString: NSAttributedString{
//            return  CurrentFormatter().makeAttributedCurrency(balance)
//        }
    }
    let viewModel: ViewModel? = nil
    
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()
    
    let moneyStackView = UIStackView()
    let moneyLabel = UILabel()
    let moneyAmountLabel = UILabel()
    
    let selectedImageView = UIImageView()

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

        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account type"
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = appColor
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.text = "Account name"
        
        moneyStackView.translatesAutoresizingMaskIntoConstraints = false
        moneyStackView.axis = .vertical
        moneyStackView.spacing = 0
        
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        moneyLabel.font = UIFont.preferredFont(forTextStyle: .body)
        moneyLabel.textAlignment = .right
        moneyLabel.text = "Some balance"
        
        moneyAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        moneyAmountLabel.textAlignment = .right
        moneyAmountLabel.attributedText = makeFormattedMoney(dollars: "929,466", cents: "23")
        
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
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
    func configure (with vm: ViewModel) {
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
//        moneyAmountLabel.attributedText = vm.balanceAsAtributedString
        
        switch vm.accountType {
        case .Banking:
            underlineView.backgroundColor = appColor
            moneyLabel.text = "Current Money"
        case.CreditCard:
            underlineView.backgroundColor = .systemOrange
            moneyLabel.text = "Balance"
        case.Investment:
            underlineView.backgroundColor = .systemBlue
            moneyLabel.text = "Value"
        }
    }
}
