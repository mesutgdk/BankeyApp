//
//  AccuntSummaryViewController.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 27.05.2023.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    // Request Models
    var profile: Profile?
    
    // View Models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    
    var accounts: [AccountSummaryCell.ViewModel] = []
    
    
    var tableView = UITableView()
    var headerView = AccountSummaryHeaderView(frame: .zero)

    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
    }
}

extension AccountSummaryViewController{
    private func setup(){
        setupTableView()
        setupTableHeaderView()
//        fetchAccounts()
        fetchDataAndLoadView()
    }
    
    private func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = appColor
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView(){
        
        
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        headerView.frame.size = size
       
        tableView.tableHeaderView = headerView
        
    }
}
extension AccountSummaryViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else { return UITableViewCell() }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
                let account = accounts[indexPath.row]
                cell.configure(with: account)
                
                return cell
    }
 }
extension AccountSummaryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AccountSummaryCell.rowHeight
    }
}
extension AccountSummaryViewController{
    private func fetchAccounts(){
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking,
                                                            accountName: "Basic Savings",
                                                        money: 929466.23)
        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking,
                                                    accountName: "No-Fee All-In Chequing",
                                                    money: 17562.44)
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard,
                                                       accountName: "Visa Avion Card",
                                                       money: 412.83)
        let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard,
                                                       accountName: "Student Mastercard",
                                                       money: 50.83)
        let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment,
                                                       accountName: "Tax-Free Saver",
                                                       money: 2000.00)
        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment,
                                                       accountName: "Growth Fund",
                                                       money: 15000.00)

        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
}
extension AccountSummaryViewController {
    
    func setupNavigationBar(){
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
}
// MARK: Actions

extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}
// Networking
extension AccountSummaryViewController {
    private func fetchDataAndLoadView() {
        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile) :
                self.profile = profile
                self.configureTableHeaderView(with: profile)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        fetchAccounts()
    }
    private func configureTableHeaderView(with: Profile){
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Bonjuor", name: profile!.firstName, date: Date())
        self.headerView.configure(viewModel: vm)
    }
}

