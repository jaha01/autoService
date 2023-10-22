//
//  JournalInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//

import Foundation

final class JounalInteractor {
    var presenter: JournalPresenter!
    var items = [JournalItem]()
    
    private let authService: AuthService!
    private let dbService: DBService!
    
    init(authService: AuthService,
         dbService: DBService) {
        self.authService = authService
        self.dbService = dbService
    }
    
    func onViewDidLoad() {
        self.dbService.fetchAllItems { allItems in
            self.items = allItems
            self.presenter.prepareToShowJournalData(self.items)
        }
    }
    
    func appenItem(text: String) {
        dbService.uploadJournalItem(text: text)
    }
}
