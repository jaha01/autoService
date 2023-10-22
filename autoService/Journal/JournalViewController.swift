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
    var items = [JournalItem]()
    
    private let journalList: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Журнал"
        view.addSubview(journalList)
        journalList.delegate = self
        journalList.dataSource = self
        view.backgroundColor = .gray
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    
        interactor.onViewDidLoad()
    }
    
    func showJournal(_ items: [JournalItem]) {
        self.items = items
        DispatchQueue.main.async { [weak self] in
            self?.journalList.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        journalList.frame = view.bounds
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
                    DispatchQueue.main.async {
                        self.interactor.appenItem(text: text)
                        self.journalList.reloadData()
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension JournalViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("delete")
        if editingStyle == .delete {
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
