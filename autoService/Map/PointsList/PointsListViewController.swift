//
//  PointsListViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 10.12.2023.
//

import Foundation
import UIKit

protocol PointsListViewControllerDelegate: AnyObject {
    func show(latitude: Double, longitude: Double)
}

final class PointsListViewController: UIViewController {
    
    // MARK: Public properties
    
    var interactor: PointsListInteractor!
    weak var delegate: PointsListViewControllerDelegate?
    
    // MARK: - Private properties
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var points = [MapPoint]()
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Places List"
        setConstraints()
    }
    
    func showPoints(list: [MapPoint]) {
        points = list
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Private methods
    
    private func setConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource Implementation
extension PointsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle , reuseIdentifier: "cell")
        cell.textLabel?.text = points[indexPath.row].title.name
        cell.detailTextLabel?.text = points[indexPath.row].title.description
        cell.selectionStyle = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.show(latitude: points[indexPath.row].point.latitude,
                       longitude: points[indexPath.row].point.longitude)
        interactor.didTapPoint()
    }
}
