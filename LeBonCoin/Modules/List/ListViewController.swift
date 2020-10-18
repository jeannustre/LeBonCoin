//
//  ViewController.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 11/10/2020.
//

import UIKit

/// The view controller for the `List` module.
class ListViewController: UIViewController {
    /// Reference to the module's presenter.
    var presenter: ListViewToPresenterProtocol?
    
    /// The table view used to display content.
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 60, right: 0)
        tableView.register(ListingTableViewCell.self, forCellReuseIdentifier: ListingTableViewCell.tableViewReuseIdentifier)
        return tableView
    }()

    /// The initializer.
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    /// IB bad
    required init?(coder: NSCoder) {
        fatalError("Please initialize ListViewController programatically only")
    }
    
    /// Initializes the view controller.
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = NamedColors.leBonBackground
        tableView.backgroundColor = NamedColors.leBonBackground
        tableView.register(ListingTableViewCell.self, forCellReuseIdentifier: ListingTableViewCell.tableViewReuseIdentifier)
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    /// Configure nav bar buttons when the categoris have been fetched.
    private func configureNavBarButtons() {
        let filterButton = presenter?.getFilterButton()
        navigationItem.setRightBarButton(filterButton, animated: true)
    }

}

/// Extension on `ListViewController` to be the `tableView`'s delegate.
extension ListViewController: UITableViewDelegate {
    
    /// Called when a row has been selected. Tells the presenter.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.listingTapped(at: indexPath)
    }
    
    /// Returns the height for rows.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

}

/// Extension on `ListViewController` to be the `tableView`'s delegate.
extension ListViewController: UITableViewDataSource {
    
    /// Dequeues and configures a row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListingTableViewCell.tableViewReuseIdentifier, for: indexPath) as! ListingTableViewCell
        cell.configure(with: presenter?.listing(at: indexPath))
        return cell
    }
    
    /// Always only one section in this app.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Asks the number of rows to the `presenter`, then returns it;
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfListings() ?? 0
    }
    
}

/// An extension of the List view controller, used to get info back from the Presenter.
extension ListViewController: ListPresenterToViewProtocol {
 
    /// Called by the presenter when listings have been fetched.
    func gotListings() {
        tableView.reloadData()
        configureNavBarButtons()
    }
    
    /// Called by the presenter when listings couldn't be fetched.
    func getListingsError() {
        let alert = UIAlertController(title: ListStrings.localized("error.title"), message: ListStrings.localized("error.description"), preferredStyle: .alert)
        let retryAction = UIAlertAction(title: ListStrings.localized("error.retry"), style: .default, handler: { [weak self] action in
            self?.presenter?.fetchListings()
        })
        alert.addAction(retryAction)
        present(alert, animated: true)
    }
    
    /// Called when the presenter wants to ask the view to present a controller.
    func presentController(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    /// Called when the presenter wants to ask the view to push a controller on the current navigation stack.
    func pushController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Called by the presenter when the table should be reloaded (typically when the filter settings have changed)
    func reloadTable() {
        tableView.reloadData()
    }
    
}
