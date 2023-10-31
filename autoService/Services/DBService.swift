//
//  DBService.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//


import FirebaseDatabase


final class DBService {
    
    private let ref = Database.database().reference()
    private var allItems = [JournalItem]()
    private let authService: AuthService
    private let journalHistoryItems = "journalHistoryItems"
    
    
    init(authService: AuthService) {
        self.authService = authService
    }

    
    func setupListeners(handler: @escaping ([JournalItem]) -> Void) {
        ref.child(journalHistoryItems).observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            if let dictionary = snapshot.value as? [String: Any] {
                self.allItems = []
                for (_, value) in dictionary {
                    print("value = \(self.allItems)")
                    if let itemData = value as? [String: Any] {
                        let journalItem = JournalItem(dictionary: itemData)
                        print("journalItem = \(journalItem)")
                        self.allItems.append(journalItem)
                    }
                }
                handler(self.allItems)
            }
        }
    }

 /*
    func getData(completion: @escaping (Result<[JournalItem], Error>) -> Void) {
        ref.child(journalHistoryItems).getData { [weak self] error, snapshot in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
            } else if let dictionary = snapshot.value as? [String: Any] {
                for (_, value) in dictionary {
                    print("value = \(self.allItems)")
                    if let itemData = value as? [String: Any] {
                        let journalItem = JournalItem(dictionary: itemData)
                        self.allItems.append(journalItem)
                    }
                }
                print("allItems = \(self.allItems)")
                completion(.success(self.allItems))
            }
        }
    }

  */
    func fetchAndObserveItem(id: String, completion: @escaping(Result<JournalItem, Error>) -> Void) {
        ref.child(journalHistoryItems).child(id).observeSingleEvent(of: .value) { snapshot in
            
            if let dictionary = snapshot.value as? [String: Any] {
                let journalItem = JournalItem(dictionary: dictionary)
                completion(.success(journalItem))
            } else  {
                completion(.failure(NetworkError.fetching("Error")))
            }
        }
    }
    
    func uploadJournalItem(text: String) {
        let id = ref.child(journalHistoryItems).childByAutoId()
        let values = ["item": text, "id": id.key!] as [String: Any]
        id.updateChildValues(values)
    }
    
    func removeJournalItem(id: String){
        ref.child(journalHistoryItems).child(id).removeValue()
    }
}
