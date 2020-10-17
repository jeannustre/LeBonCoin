//
//  ViewController.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 11/10/2020.
//

import UIKit

class ListViewController: UIViewController {
    
    var presenter: ListViewToPresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.prefetchDataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 60, right: 0)
        tableView.register(ListingTableViewCell.self, forCellReuseIdentifier: ListingTableViewCell.tableViewReuseIdentifier)
        return tableView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Please initialize ListViewController programatically only")
    }
    
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
    
    private func configureNavBarButtons() {
        let filterButton = presenter?.getFilterButton()
        navigationItem.setRightBarButton(filterButton, animated: true)
    }

}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.listingTapped(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListingTableViewCell.tableViewReuseIdentifier, for: indexPath) as! ListingTableViewCell
        cell.configure(with: presenter?.listing(at: indexPath))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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
        
    }
    
    func presentController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
//        present(viewController, animated: true, completion: nil)
    }
    
    /// Called by the presenter when the table should be reloaded (typically when the filter settings have changed)
    func reloadTable() {
        tableView.reloadData()
    }
    
}
