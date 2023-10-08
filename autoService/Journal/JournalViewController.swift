//
//  JournalViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 29.08.2023.
//

import UIKit

final class JournalViewController: UIViewController {

    var interactor: JournalInteractor!
    
    var items = [String]()
    
    // MARK: - Pivate properties
    private let journalList: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Журнал"
        view.addSubview(journalList)
        journalList.delegate = self
        journalList.dataSource = self
        view.backgroundColor = .gray
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }

    
    @objc private func didTapAdd() {
     print("didTapAdd")
        let alert = UIAlertController(title: "Добавить", message: "Добавьте новую запись", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Введите запись"
        }
        alert.addAction(UIAlertAction(title: "Готово", style: .default, handler: { [weak self] _ in
            guard let self = self else {
                return
            }
            if let field = alert.textFields?.first {
                if let text = field .text, !text.isEmpty {
                    DispatchQueue.main.async {
                        print("add")
                        self.items.append(text)
                        self.journalList.reloadData()
//                        UserDefaults.standard.setValue(self.items, forKey: "items")
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        journalList.frame = view.bounds
    }
}

extension JournalViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row] as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("delete")
        if editingStyle == .delete {
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            UserDefaults.standard.setValue(self.items, forKey: "items")
        }
    }
}
