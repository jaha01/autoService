//
//  JournalInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//

import Foundation

final class JounalInteractor {
    // MARK: - Public properties
    var presenter: JournalPresenter!
    var router: JournalRouter!
    
    // MARK: - Private properties
    private var items = [JournalItem]()
    private let authService: AuthService!
    private let dbService: DBService!
    
    init(authService: AuthService,
         dbService: DBService) {
        self.authService = authService
        self.dbService = dbService
    }
    
    // MARK: - Public methods
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
    // MARK: - Private methods
    private func fetchAllItems () {
        self.dbService.fetchAndObserveItems { allItems in
            self.items = allItems
            self.presenter.prepareToShowJournalData(self.items)
        }
    }
}
