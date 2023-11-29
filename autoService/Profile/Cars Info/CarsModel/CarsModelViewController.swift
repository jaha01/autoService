//
//  CarsModelViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import Foundation
import UIKit

protocol CarsModelViewControllerDelegate {
    func chosen(brand: String)
}

final class CarsModelViewController: UIViewController {
    
    // MARK: - Public properties
    
    var interactor: CarsModelInteractor!
    var delegate: CarsModelViewControllerDelegate!
    var profileViewController: ProfileViewController!
    
    // MARK: - Private properties
    
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
        interactor.loadCarsList(query: "")
    }
    
    func showCarsList(cars: [String]) {
        carsList = cars
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func showErrorAlert(config: AlertConfig) {
        AlertManager.showAlert(config: config)
    }
    
    //MARK: - Private methods
    
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
        cell.selectionStyle = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate = profileViewController
        delegate?.chosen(brand: carsList[indexPath.row])
//        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
//        dismiss(animated: true) // хочу чтоб после выбора bottom sheet скрылся - не скрывается
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            interactor.loadCarsList(query: searchText)
    }
    
}
