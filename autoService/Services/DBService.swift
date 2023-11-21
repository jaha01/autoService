//
//  DBService.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//


import FirebaseDatabase
import FirebaseAuth


final class DBService {
    
    private let ref = Database.database().reference()
    private var allItems = [JournalItem]()
    private let authService: AuthService
    private let journalHistoryItems = "journalHistoryItems"
    private let profileInformation = "ProfileInformation"
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func setupListeners(handler: @escaping ([JournalItem]) -> Void) {
        ref.child(authService.getUserID()).child(journalHistoryItems).observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            if let dictionary = snapshot.value as? [String: Any] {
                self.allItems = []
                for (_, value) in dictionary {
                    if let itemData = value as? [String: Any] {
                        let journalItem = JournalItem(dictionary: itemData)
                        self.allItems.append(journalItem)
                    }
                }
                handler(self.allItems)
            }
        }
    }
    
    func uploadJournalItem(text: String) {
        
        let parent = ref.child(authService.getUserID()).child(journalHistoryItems)
        let id = parent.childByAutoId()
        let values = ["item": text, "id": id.key!] as [String: Any]
        id.updateChildValues(values)
    }
    
    
    func removeJournalItem(id: String){
        ref.child(authService.getUserID()).child(journalHistoryItems).child(id).removeValue()
    }
    
    func setupProfileInfoListeners(handler: @escaping ([String: Any]) -> Void) {
        ref.child(authService.getUserID()).child(profileInformation).observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            if let dictionary = snapshot.value as? [String: Any] {
                handler(dictionary)
            }
        }
    }
    
    func uploadProfileInfo(profileInfo: ProfileInfoNew) {
        
        let parent = ref.child(authService.getUserID()).child(profileInformation)
        let values = ["id": parent.key!, "email": profileInfo.email, "phone": profileInfo.phone, "name": profileInfo.name, "city": profileInfo.city, "experience": profileInfo.experience, "bday": profileInfo.bday,"brand": profileInfo.brand, "model": profileInfo.model, "year": profileInfo.year, "volume": profileInfo.volume, "mileage": profileInfo.mileage] as [String: Any]
        parent.updateChildValues(values)
    }
}
