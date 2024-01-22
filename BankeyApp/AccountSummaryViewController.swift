//
//  AccuntSummaryViewController.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 27.05.2023.
//

import UIKit

final class AccountSummaryViewController: UIViewController {
    
    // Request Models
    var profile: Profile?
    lazy var accounts: [Account] = []
    
    // View Models
    private let headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    
    lazy var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
    
    // Components
    private let tableView : UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = appColor
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
        
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControl = UIRefreshControl()
    
    // Networking
    private let profileManager: ProfileManageable = ProfileManager()
    
    // Error alert
    lazy var errorAlert: UIAlertController = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }()
    
    lazy var isLoaded = false
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AccountSummaryViewController{
    private func setup(){
        setupTableView()
        setupTableHeaderView()
        setupNavigationBar()
        setupRefreshControl()
        setupSkeleton()
        fetchData()
    }
    
    private func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
extension AccountSummaryViewController {
    
    func setupNavigationBar(){
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    private func setupRefreshControl(){
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupSkeleton() {
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 10)
        
        configureTableCell(with: accounts)
        
    }
}
extension AccountSummaryViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else { return UITableViewCell() }
        let account = accountCellViewModels[indexPath.row]
        
        if isLoaded { // eğer yüklenmişse hesabı çek yoksa skeletondan
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
            cell.configure(with: account)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
        return cell
    }
 }
extension AccountSummaryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AccountSummaryCell.rowHeight
    }
}


// Networking
extension AccountSummaryViewController {
    private func fetchData() {
        
        let group = DispatchGroup()
        
        // testing - random number selector
        let userId = String(Int.random(in: 1..<4))
        
        fetchProfile(group: group, userId: userId)
        fetchAccount(group: group, userId: userId)
       
        // this code only run after upers are completed
        group.notify(queue: .main) {
            self.reloadView()
        }
    }
    
    private func fetchProfile(group:DispatchGroup, userId: String){
        group.enter()
        profileManager.fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile) :
                self.profile = profile
            case .failure(let error):
                self.displayError(error)
//                print(error.localizedDescription)
            }
            group.leave()
        }
    }
    
    private func fetchAccount(group: DispatchGroup, userId: String){
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                self.displayError(error)
//              print(error.localizedDescription)
            }
            group.leave()
        }
    }
    
    private func reloadView(){
        self.tableView.refreshControl?.endRefreshing()

        guard let profile = self.profile else {return}
        
        self.isLoaded = true
        self.configureTableHeaderView(with: profile)
        self.configureTableCell(with: self.accounts)
        self.tableView.reloadData()
    }
    
    private func configureTableHeaderView(with: Profile){
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Bonjuor", name: profile!.firstName, date: Date())
        self.headerView.configure(viewModel: vm)
    }
    
    private func configureTableCell(with accounts: [Account]) {
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type,
                                         accountName: $0.name,
                                         money: $0.amount)
        }
    }
    /* Error mesajları: switch error la hangi error durumuna göre showFunc'a girdi veriyoruz
     mesajı her yerde kullanabilmek için ayrı func yaptık, teste tabi tuabilmek için girdileri ayrdık, ayrı bi func yaptık, sırasıyla displayerror-titleandmessage-showerrorlaert çağrılıyor
     */
    private func displayError( _ error : NetworkError){
        let titleAndMessage = titleAndMessage(for: error)
        self.showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1)
    }
    private func titleAndMessage(for error: NetworkError) -> (String,String) {
        let title:String
        let message:String
        
        switch error {
        case .decodingError:
            title = "Decoding Error"
            message = "We could not process your request. Please try again."
        case .serverError:
            title = "Server Error"
            message = "Ensure you are connected to the internet. Please try again!"
        }
       return (title,message)
    }
    
    // common func to call for showing alert
    private func showErrorAlert(title: String, message:String){

        errorAlert.title = title
        errorAlert.message = message
        present(errorAlert, animated: true,completion: nil)
    }
    
}
// MARK: Actions

extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    @objc func refreshContent(){
        reset()
        setupSkeleton()
        tableView.reloadData()
        fetchData()
    }
    
    private func reset (){
        profile = nil
        accounts = []
        isLoaded = false
    }
}
// MARK: - Unit Testing
extension AccountSummaryViewController{
    func titleAndMessageForTesting(for error: NetworkError) -> (String,String) {
        return titleAndMessage(for: error)
    }
    
    func forceFetchProfile(){
        fetchProfile(group: DispatchGroup(), userId: "1")
    }
} // it gives the access to a private func to be tested
