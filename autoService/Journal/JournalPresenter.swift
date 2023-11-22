//
//  JournalPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//

import Foundation

final class JournalPresenter {
    // MARK: - Public properties
    var viewController: JournalViewController!
    
    // MARK: - Public methods
    func prepareToShowJournalData(_ items: [JournalItem]) {
        viewController.showJournal(items)
    }
    
    func showError(errorText: String) {
        viewController.showErrorAlert(errorText: errorText)
    }
}
