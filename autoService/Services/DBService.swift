//
//  DBService.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//


import FirebaseDatabase
import FirebaseAuth

//protocol ?
final class DBService {
    
    private let ref = Database.database().reference()
    private var allItems = [JournalItem]()
    private let authService: AuthService
    private let journalHistoryItems = "journalHistoryItems"
    private let profileInformation = "profileInformation"
    private let mapPoints = "mapPoints"
    
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
    
    func setupProfileInfoListeners(handler: @escaping (ProfileInfo) -> Void) {
        ref.child(authService.getUserID()).child(profileInformation).observe(.value) { snapshot in
            if let dictionary = snapshot.value as? [String: Any] {
                let profileDetails =
                ProfileInfo(json: dictionary)
                handler(profileDetails)
            }
        }
    }
    
    func uploadProfileInfo(profileInfo: ProfileInfo) {
        let parent = ref.child(authService.getUserID()).child(profileInformation)
        let values = profileInfo.toJson()
        parent.updateChildValues(values)
    }
    
    func setupMapPointsListeners(handler: @escaping ([MapPoint]) -> Void) {
        ref.child(authService.getUserID()).child(mapPoints).observe(.value) { snapshot in
            if let dictionary = snapshot.value as? [String: Any] {
                handler(dictionary.map { MapPoint(dictionary: $0.value as! [String : Any])})
            }
        }
    }
    
    func uploadMapPoint(pointInfo: MapPoint) {
        let parent = ref.child(authService.getUserID()).child(mapPoints)
        let id = parent.childByAutoId()
        let values = ["id": id.key! ,
                      "name": pointInfo.title.name,
                      "description": pointInfo.title.description,
                      "latitude": pointInfo.point.latitude,
                      "longitude": pointInfo.point.longitude] as [String : Any]
        id.updateChildValues(values)
    }
}
