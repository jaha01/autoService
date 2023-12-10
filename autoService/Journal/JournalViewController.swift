//
//  JournalViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 29.08.2023.
//

import UIKit

class JournalViewController: UIViewController {
    
    // MARK: - Properties
    var interactor: JounalInteractor!
    private var items = [JournalItem]()
    
    private let journalList: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let emptyListImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "emptyList")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Журнал"
        view.addSubview(journalList)
        view.addSubview(emptyListImage)
        journalList.delegate = self
        journalList.dataSource = self
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        setConstraints()
        interactor.onViewDidLoad()
    }
    
    func showJournal(_ items: [JournalItem]) {
        self.items = items
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.journalList.isHidden = self.items.isEmpty
            self.emptyListImage.isHidden = !self.items.isEmpty
            self.journalList.reloadData()
        }
    }
    
    
    func showErrorAlert(config: AlertConfig) {
        AlertManager.showAlert(config: config)
    }
    // MARK: - Private properties
    
    @objc private func didTapAdd() {
        AlertManager.addJournalItemAlert { [weak self] text in
            guard let self = self else { return }
            self.interactor.appendItem(text: text)
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            journalList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            journalList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            journalList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            journalList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyListImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyListImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyListImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyListImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension JournalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor.deleteItem(id: self.items[indexPath.row].id)
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
