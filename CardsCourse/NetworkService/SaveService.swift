//
//  NetworkServices.swift
//  CardsCourse
//
//  Created by PavelM on 14/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit
import Firebase


class SaveService {
  

  
  static func saveRegisterDataInFireStore(imageUrlString: String, fullName: String, complation: @escaping ((Result<Bool, NetworkFirebaseError>) -> Void)) {
    
    guard let currentUserID = Auth.auth().currentUser?.uid else {return}
    
    let docData: [String:Any] = [
      UserKey.name.rawValue: fullName,
      UserKey.imageArray.rawValue: [imageUrlString,"",""],
      UserKey.userId.rawValue: currentUserID,
      UserKey.minSeekingAge.rawValue: SettingsController.defaultMinSeekingAge,
      UserKey.maxSeekingAge.rawValue: SettingsController.defaultMaxSeekingAge
    ]
    
    // Просим сохранить в базе данных по ключу который был получен при регистрации!
  Firestore.firestore().collection("users").document(currentUserID).setData(docData) { (error) in
      if let error = error {
        complation(.failure(.saveDocumentError))
      }
      
      complation(.success(true))
    }
  }
  

  
  static func saveSettingsDataInFireStore(user:User, complation: @escaping ((Result<Bool, NetworkFirebaseError>) -> Void)) {
    
    guard let currentUserID = Auth.auth().currentUser?.uid else {return}

    var docData:[String: Any] = [
      UserKey.name.rawValue: user.name ?? "",
      UserKey.profession.rawValue: user.profession ?? "",
      UserKey.imageArray.rawValue: user.imageURlArray ?? ["","",""],
      UserKey.userId.rawValue: user.userID ?? "",
      UserKey.minSeekingAge.rawValue: user.minSeekingAge ?? SettingsController.defaultMinSeekingAge,
      UserKey.maxSeekingAge.rawValue: user.maxSeekingAge ?? SettingsController.defaultMaxSeekingAge
    ]
    
    if let age = user.age {
      docData[UserKey.age.rawValue] = age
    }
    

    Firestore.firestore().collection("users").document(currentUserID).setData(docData) { (error) in
      if let error = error {
        complation(.failure(.saveDataFromSettingsError))
      }
      // Сохранение прошло успешно!
      complation(.success(true))
    }
    
    
  }
  
  static func saveImageInStorage(image: UIImage, complation: @escaping ((Result<URL, NetworkFirebaseError>) -> Void)) {
    
    let filename = UUID().uuidString
    let ref = Storage.storage().reference(withPath: "/images/\(filename)")
    let imageData = image.jpegData(compressionQuality: 0.75) ?? Data()
    
    ref.putData(imageData, metadata: nil) { (_, err) in
      
      if let err = err {
        complation(.failure(.loadDataInStorageError))
      }
      print("Finishing Loading in Storage!")
      // Получить URL Картинки!
      ref.downloadURL(completion: { (url, err) in
        
        if let err = err {
          complation(.failure(.getImageUrlError))
        }
        
        if let url = url {
          complation(.success(url))
        }
        
      })
    }
  }
  
  static func saveSwipeToFirestore(cardUID: String, like: Int,complation: @escaping ((Result<Bool, NetworkFirebaseError>) -> Void)) {
    
    let documentData = [cardUID:like]

    
    guard let currenUserID = NetworkService.currentUserID else {return}
    let collectionKey = CollectionKey.swipes.rawValue
    
    // Сначала мы проверим Создан ли документ для пользователя
    Firestore.firestore().collection(collectionKey).document(currenUserID).getDocument { (snapShot, error) in
      if let error = error {
        print("Ошибка подключения к базе", error.localizedDescription)
        return
      }
      
      if snapShot?.exists == true {
        // Update добавляет к полю новые данные!
        Firestore.firestore()
          .collection(collectionKey)
          .document(currenUserID)
          .updateData(documentData, completion: { (error) in
          if let error = error {
            complation(.failure(.saveSwipeToFirestore))
          }
          complation(.success(true))
          
        })
      } else {
        
        Firestore.firestore()
          .collection(collectionKey)
          .document(currenUserID)
          .setData(documentData) { (error) in
            if let error = error {
              complation(.failure(.saveSwipeToFirestore))
            }
            complation(.success(true))
            
        }
      }
    }
    
    
    
    
  }

  
}


