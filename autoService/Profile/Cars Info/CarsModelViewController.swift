//
//  CarsModelViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import Foundation
import UIKit

class CarsModelViewController: UIViewController {
    
    // MARK: - Private properties
    private let searchVC = UISearchController(searchResultsController: nil)
    private let carsService: CarsService!
    private let list = [String]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Public methods
    init(carsService: CarsService) {
        self.carsService = carsService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        navigationItem.title = "Cars List"
        tableView.delegate = self
        tableView.dataSource = self
        setConstraints()
        createSearchBar()
        
        carsService.loadCars { (result: Result<self.list, Error>)  in
            
        }
        
    }
    
    
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "BMW"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}
