//
//  Enums.swift
//  CardsCourse
//
//  Created by PavelM on 18/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import Foundation

enum UserKey: String {
  case name = "FullName"
  case age = "Age"
  case profession = "Proffesion"
  case imageArray = "imageURLArray"
  case userId = "userID"
  
  case minSeekingAge = "minSeekingAge"
  case maxSeekingAge = "maxSeekingAge"
}

enum CollectionKey: String {
  
  case users = "users"
  case swipes = "swipes"
  case matchesAndMessages = "matches_messages"
  case matches = "matches"
}

enum NetworkFirebaseError: Error {
  case createUserError
  case loadDataInStorageError
  case getImageUrlError
  case saveDocumentError
  case fetchingUserError
  case fetchUserImageError
  case fetchCurrentUserError
  case saveDataFromSettingsError
  case signInError
  case saveSwipeToFirestore
  case fetchSwipes
}
