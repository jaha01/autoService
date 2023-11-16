//
//  ProfileViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 29.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    var interactor: ProfileInteractor!
    var profileInfo = [ProfileInfo]()
    
    // MARK: - Pivate properties
    
    let profileTable: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 10
        return table
    }()
    
    
    // MARK: - Public method

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        view.addSubview(profileTable)
        profileTable.dataSource = self
        profileTable.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        setupConstraints()
        interactor.onViewDidLoad()
        
        let profileTableHeader = ProfileTableHeader(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        profileTable.tableHeaderView = profileTableHeader
    }
    
    func showErrorAlert(config: AlertConfig) {
        AlertManager.showAlert(config: config)
    }
    
    func pushProfileData(items: [ProfileInfo]) {
        profileInfo = items
        DispatchQueue.main.async { [weak self] in
            self?.profileTable.reloadData()
        }
    }
    
    // MARK: - Private methods
    @objc private func didTapLogout() {
        interactor.didTapSignOut()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
         
            profileTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return profileInfo[section].section
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileInfo.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileInfo[section].item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = profileInfo[indexPath.section].item[indexPath.row].placeholder
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && indexPath.row == 0 {
            interactor.carsList(navController: navigationController)
        }
            
    }
    
}
