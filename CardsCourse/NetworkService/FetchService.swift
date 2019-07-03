//
//  FetchFromFireStore.swift
//  CardsCourse
//
//  Created by PavelM on 18/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit
import Firebase



class FetchService {
  
  // order: String,after: Any, limit: Int
  
  static func fetchUsersFromFirestore(minAge: Int, maxAge: Int,complation: @escaping ((Result<Dictionary<String, Any>,NetworkFirebaseError>) -> Void)) {
    
    
    // Запрос пользователей 1 за 1 по лимиту
//    let query = Firestore.firestore().collection("users").order(by: order).start(after: [after]).limit(to: limit)
    
    // All USers
    let ageField = UserKey.age.rawValue
    let query = Firestore.firestore().collection("users").whereField(ageField, isGreaterThanOrEqualTo: minAge).whereField(ageField, isLessThanOrEqualTo: maxAge)
    
    query.getDocuments { (snapShot, error) in
      if let error = error {
        complation(.failure(.fetchingUserError))
      }
      
      snapShot?.documents.forEach({ (documentSnapshot) in
        let userDictionary = documentSnapshot.data()
        complation(.success(userDictionary))
      })
      
    }
    
  }
  
  static func fetchCurrentUserFromFirestore(complation: @escaping ((Result<Dictionary<String, Any>,NetworkFirebaseError>) -> Void)) {
    
    guard let currentUserID = Auth.auth().currentUser?.uid else {return}

    Firestore.firestore().collection("users").document(currentUserID).getDocument { (snapshot, error) in
      
      if let error = error {
        complation(.failure(.fetchCurrentUserError))
      }
      
      if let snapshotData = snapshot?.data() {
        complation(.success(snapshotData))
      }
    }
  }
  
  static func fetchSwipes(complation: @escaping ((Result<Dictionary<String, Int>,NetworkFirebaseError>) -> Void)) {
    
    Firestore.firestore()
      .collection(CollectionKey.swipes.rawValue).document(NetworkService.currentUserID ?? "")
      .getDocument { (snapsShot, error) in
        if let error = error {
          complation(.failure(.fetchSwipes))
        }
        guard let data = snapsShot?.data() as? [String: Int] else {
          complation(.failure(.fetchSwipes))
          return
        }
        
        complation(.success(data))
        
    }
  }
  
  static func fetchUserToCardID(cardID: String,complation: @escaping ((Result<Dictionary<String, Any>,Error>) -> Void)) {
    
    Firestore.firestore().collection(CollectionKey.users.rawValue).document(cardID).getDocument { (snapshot, error) in
      if let error = error {
        complation(.failure(error))
      }
      
      if let data = snapshot?.data() {
        complation(.success(data))
      }
      
    }
  }
  
  static func fetchMatches(complation: @escaping ((Result<[Match],Error>) -> Void)) {
    guard let currentUserID = NetworkService.currentUserID else {return}
    print(currentUserID)
    Firestore.firestore().collection(CollectionKey.matchesAndMessages.rawValue).document(currentUserID).collection(CollectionKey.matches.rawValue).getDocuments { (snapshot, error) in
      if let error = error {
        complation(.failure(error))
      }
      
      var matchArray = [Match]()
      snapshot?.documents.forEach({ (documentSnapshot) in
        let data = documentSnapshot.data() as! [String: String]
        let match = Match(name: data["name"] ?? "", profileImageUrl: data["profileImageUrl"] ?? "")
        matchArray.append(match)

      })
      
      complation(.success(matchArray))
      
      
    }
  }
  
}

// let query = Firestore.firestore().collection("users")


// Запрос по условию! Из базы данных!
//    let query = Firestore.firestore().collection("users").whereField("age", isEqualTo: 29)

// Запрос с условием Меньше чем 33!
//    let query = Firestore.firestore().collection("users").whereField("age", isLessThan: 33)

// Запрос с условием в диапозоне
//    let query = Firestore.firestore().collection("users").whereField("age", isGreaterThan: 30).whereField("age", isLessThan: 35)

// Запрос по полю с массивом и пореджеленным значением из массива!
//    let query = Firestore.firestore().collection("users").whereField("friends", arrayContains: "Elena")
