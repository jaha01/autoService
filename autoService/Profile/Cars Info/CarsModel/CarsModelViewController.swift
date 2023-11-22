//
//  CarsModelViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import Foundation
import UIKit

final class CarsModelViewController: UIViewController {
    
    // MARK: - Private properties
    var interactor: CarsModelInteractor!
    private let searchVC = UISearchController(searchResultsController: nil)
    private var carsList = [String]()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        navigationItem.title = "Cars List"
        setConstraints()
        createSearchBar()
        interactor.loadCarsList(query: "fo")
        
    }
    
    func pushCarsList(cars: [String]) {
        carsList = cars
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showErrorAlert(config: AlertConfig) {
        AlertManager.showAlert(config: config)
    }
    
    //MARK: Private methods
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}


extension CarsModelViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = carsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
