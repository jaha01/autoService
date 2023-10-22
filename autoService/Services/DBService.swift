//
//  DBService.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//

import UIKit
import FirebaseDatabase

struct JournalItem {
    var name: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["item"] as? String ?? ""
    }
}


final class DBService {
    let ref = Database.database().reference()
    var allItems = [JournalItem]()

    private let authService: AuthService
    
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func fetchAllItems(completion: @escaping([JournalItem]) -> Void) {
        ref.child("items").observe(.childAdded) { (snapshot) in
            self.fetchSingleItem(id: snapshot.key) { item in
                self.allItems.append(item)
                completion(self.allItems)
            }
        }
    }
    
    func fetchSingleItem(id: String, completion: @escaping(JournalItem) -> Void) {
        ref.child("items").child(id).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any]
            else { return }
            let journalItem = JournalItem(dictionary: dictionary)
            completion(journalItem)
        }
    }
    
    func uploadJournalItem(text: String) {
        let values = ["item": text]
        
        ref.child("items").childByAutoId().updateChildValues(values)
    }
}
