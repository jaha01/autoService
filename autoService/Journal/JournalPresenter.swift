//
//  JournalPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//

import Foundation

final class JournalPresenter {
    var viewController: JournalViewController!
    
    func prepareToShowJournalData(_ items: [JournalItem]) {
        viewController.showJournal(items)
        print("presenter items = \(items)")
    }
}
