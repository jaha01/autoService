//
//  JournalInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//

import Foundation

protocol JounalInteractorProtocol {
    func onViewDidLoad()
    func appendItem(text: String)
    func deleteItem(id: String) 
}

final class JounalInteractor: JounalInteractorProtocol {
    // MARK: - Public properties
    var presenter: JournalPresenter!
    var router: JournalRouter!
    
    // MARK: - Private properties
    private var items = [JournalItem]()
    private let authService: AuthService
    private let dbService: DBService
    
    init(authService: AuthService,
         dbService: DBService) {
        self.authService = authService
        self.dbService = dbService
    }
    
    // MARK: - Public methods
    func onViewDidLoad() {
        dbService.setupListeners(handler: { [weak self] items in
            guard let self = self else { return }
            self.items = items
            self.presenter.prepareToShowJournalData(self.items)
        })
    }
    
    func appendItem(text: String) {
        dbService.uploadJournalItem(text: text)
    }
    
    func deleteItem(id: String) {
        self.dbService.removeJournalItem(id: id)
    }
}
