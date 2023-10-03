//
//  AuthentificationService.swift
//  autoService
//
//  Created by Jahongir Anvarov on 03.10.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
 /// THIS FILE IS NOT CURRENTLY IN USAGE
class AuthentificationService {
    public static let shared = AuthentificationService()
    
    private init() {
        
    }
    
    public func registerUser(with userRequest: RegisterUserRequest, completion: @escaping(Error?) -> Void) {
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
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
    
    public func signIn(with userRequest: LoginUserRequest, completion: @escaping(Error?)->Void) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) {
            result, error in
            if let error = error {
                completion(error)
//                result
            } else {
                completion(nil)
            }
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
    
    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
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
                }
            }
    }
}
