//
//  DBService.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//


import FirebaseDatabase
import FirebaseAuth

protocol JournalServiceProtocol {
    func setupJournalListener(handler: @escaping ([JournalItem]) -> Void)
    func uploadJournalItem(text: String)
    func removeJournalItem(id: String)
}

protocol ProfileInfoServiceProtocol {
    func setupProfileInfoListeners(handler: @escaping (ProfileInfo) -> Void)
    func uploadProfileInfo(profileInfo: ProfileInfo)
}

protocol MapPointsServiceProtocol {
    func setupMapPointsListeners(handler: @escaping ([MapPoint]) -> Void)
    func uploadMapPoint(pointInfo: MapPoint)
    func removeMapPoint(id: String)
}

final class DBService: JournalServiceProtocol, ProfileInfoServiceProtocol, MapPointsServiceProtocol {
    
    private let ref = Database.database().reference()
    private let authService: AuthServiceProtocol
    private let journalHistoryItems = "journalHistoryItems"
    private let profileInformation = "profileInformation"
    private let mapPoints = "mapPoints"
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    // MARK: - JournalServiceProtocol Implemenatation

    func setupJournalListener(handler: @escaping ([JournalItem]) -> Void) {
        ref.child(authService.getUserID()).child(journalHistoryItems).observe(.value) { snapshot in
            if let dictionary = snapshot.value as? [String: Any] {
                handler(dictionary.map { JournalItem(dictionary: $0.value as! [String: Any])})
            }
        }
    }
    
    func uploadJournalItem(text: String) {
        
        let parent = ref.child(authService.getUserID()).child(journalHistoryItems)
        let id = parent.childByAutoId()
        let values = ["item": text, "id": id.key!] as [String: Any]
        id.updateChildValues(values)
    }
    
    
    func removeJournalItem(id: String) {
        ref.child(authService.getUserID()).child(journalHistoryItems).child(id).removeValue()
    }
    
    // MARK: - ProfileInfoServiceProtocol Implemenatation
    
    func setupProfileInfoListeners(handler: @escaping (ProfileInfo) -> Void) {
        ref.child(authService.getUserID()).child(profileInformation).observe(.value) { snapshot in
            if let dictionary = snapshot.value as? [String: Any] {
                handler(ProfileInfo(json: dictionary))
            }
        }
    }
    
    func uploadProfileInfo(profileInfo: ProfileInfo) {
        let parent = ref.child(authService.getUserID()).child(profileInformation)
        let values = profileInfo.toJson()
        parent.updateChildValues(values)
    }
    
    // MARK: - MapPointsServiceProtocol Implemenatation
    
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
        var values = pointInfo.toJson()
        values["id"] = id.key!
        id.updateChildValues(values)
    }
    
    func removeMapPoint(id: String) {
        ref.child(authService.getUserID()).child(mapPoints).child(id).removeValue()
    }
}
