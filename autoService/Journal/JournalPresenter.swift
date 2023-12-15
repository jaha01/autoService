//
//  JournalPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//

import Foundation

protocol JournalPresenterProtocol {
    func prepareToShowJournalData(_ items: [JournalItem])
    func showError(errorText: String)
}

final class JournalPresenter: JournalPresenterProtocol {
    // MARK: - Public properties
    var viewController: JournalViewController!
    
    // MARK: - Public methods
    func prepareToShowJournalData(_ items: [JournalItem]) {
        viewController.showJournal(items)
    }
    
    func showError(errorText: String) {
        viewController.showErrorAlert(config: AlertConfig.init(title: errorText))
    }
}
