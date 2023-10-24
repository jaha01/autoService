//
//  JournalInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//

import Foundation

final class JounalInteractor {
    var presenter: JournalPresenter!
    var router: JournalRouter!
    
    private var items = [JournalItem]()
    private let authService: AuthService!
    private let dbService: DBService!
    
    init(authService: AuthService,
         dbService: DBService) {
        self.authService = authService
        self.dbService = dbService
    }
    
    private func fetchAllItems () {
        self.dbService.fetchAndObserveItems { allItems in
            self.items = allItems
            self.presenter.prepareToShowJournalData(self.items)
            print("interactor items = \(self.items)")
        }
    }
    
    func onViewDidLoad() {
        fetchAllItems()
    }
    
    func appendItem(text: String) {
        DispatchQueue.main.async {
            self.dbService.uploadJournalItem(text: text)
        }
        fetchAllItems()
    }
    
    func deleteItem(id: String) {
        DispatchQueue.main.async {
            self.dbService.removeJournalItem(id: id)
        }
        fetchAllItems()
    }
}
