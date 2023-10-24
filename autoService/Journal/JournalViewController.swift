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
        self.items = []
        self.items = items
        print("view items = \(items)")
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
            self.journalList.isHidden = self.items.isEmpty ? true : false
            self.emptyListImage.isHidden = self.items.isEmpty ? false : true
            self.journalList.reloadData()
        }
    }
    
    // MARK: - Private properties
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "Добавить", message: "Добавьте новую запись", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Введите запись"
        }
        alert.addAction(UIAlertAction(title: "Готово", style: .default, handler: { [weak self] _ in
            guard let self = self else {
                return
            }
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    self.interactor.appendItem(text: text)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            journalList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            journalList.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            journalList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            journalList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyListImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyListImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyListImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyListImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension JournalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor.deleteItem(id: items[indexPath.row].id)
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
