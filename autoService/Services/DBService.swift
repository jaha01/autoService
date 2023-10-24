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
    var id: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["item"] as? String ?? ""
        self.id = dictionary["id"] as? String ?? ""
    }
}


final class DBService {
    
    private let ref = Database.database().reference()
    private var allItems = [JournalItem]()
    private let authService: AuthService
    private let mainBranch = "journalHistoryItems"
    
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func fetchAndObserveItems(completion: @escaping([JournalItem]) -> Void) {
        ref.child(mainBranch).observe(.childAdded) { (snapshot) in
            self.fetchAndObserveItem(id: snapshot.key) { item in
                switch item {
                case .success(let newItem):
                    self.allItems.append(newItem)
                    completion(self.allItems)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func fetchAndObserveItem(id: String, completion: @escaping(Result<JournalItem, Error>) -> Void) {
        ref.child(mainBranch).child(id).observeSingleEvent(of: .value) { snapshot in

            if let dictionary = snapshot.value as? [String: Any] {
                let journalItem = JournalItem(dictionary: dictionary)
                completion(.success(journalItem))
            } else  {
                completion(.failure(NetworkError.fetching("Error")))
            }
        }
    }
    
    func uploadJournalItem(text: String) {
        let id = ref.child(mainBranch).childByAutoId()
        let values = ["item": text, "id": id.key!] as [String: Any]
        id.updateChildValues(values)
    }
    
    func removeJournalItem(id: String){
        ref.child(mainBranch).child(id).removeValue()
    }
}
