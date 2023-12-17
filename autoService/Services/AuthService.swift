//
//  AuthService.swift
//  autoService
//
//  Created by Jahongir Anvarov on 13.09.2023.
//

import FirebaseAuth
import FirebaseFirestore

protocol AuthServiceProtocol {
    func isNewUser() -> Bool
    func setIsNotNewUser()
    func registerUser(with userCredentials: RegisterUserCredentials, completion: @escaping(Error?) -> Void)
    func signIn(with userCredentials: LoginUserCredentials, completion: @escaping(Error?)->Void)
    func signOut(completion: @escaping (Error?)->Void)
    func resetPassword(with email: String, completion: @escaping (Error?) -> Void)
    func fetchUser(completion: @escaping (User?, Error?) -> Void)
    func isCurrentUserExists() -> Bool
    func getUserID() -> String
    func getUserEmail() -> String
}

final class AuthService: AuthServiceProtocol {
    private let isNotNewUserKey = "isNotNewUser"
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: isNotNewUserKey)
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: isNotNewUserKey)
    }
    
    public func registerUser(with userCredentials: RegisterUserCredentials, completion: @escaping(Error?) -> Void) {
        let username = userCredentials.username
        let email = userCredentials.email
        let password = userCredentials.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(nil)
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": email
                ]) { error in
                    if let error = error {
                        completion(error)
                        return
                    }
                    completion(nil)
                }
        }
    }
    
    public func signIn(with userCredentials: LoginUserCredentials, completion: @escaping(Error?)->Void) {
        Auth.auth().signIn(withEmail: userCredentials.email, password: userCredentials.password) {
            result, error in
            completion(error)
        }
    }
    
    public func signOut(completion: @escaping (Error?)->Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    public func resetPassword(with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    public func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userUID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let username = snapshotData["username"] as? String,
                   let email = snapshotData["email"] as? String {
                     let user = User(username: username, email: email, userUID: userUID)
                     completion(user, nil)
                } else {
                    completion(nil, NetworkError.fetching("Local Error while log in"))
                }
            }
    }
    
    public func isCurrentUserExists() -> Bool {
        return FirebaseAuth.Auth.auth().currentUser != nil
    }
    
    public func getUserID() -> String {
        guard let userID = Auth.auth().currentUser?.uid else { return ""}
        return userID
    }

    public func getUserEmail() -> String {
        guard let email = Auth.auth().currentUser?.email else { return ""}
        return email
    }
}
