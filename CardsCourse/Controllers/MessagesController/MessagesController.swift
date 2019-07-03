//
//  MessagesController.swift
//  CardsCourse
//
//  Created by PavelM on 02/07/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class MessagesController: UICollectionViewController {
  
  private let matchCellID = "MatchCellID"
  private let messagesCellID = "MessagesCellID"
  
  private let heightNavBar: CGFloat = 120
  
  
  var matchArray = [
    Match(name: "Paul", profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/cardsmatchfirebase-1a9ac.appspot.com/o/images%2F2E2C44B9-3796-4AC3-8D85-55AEF0A41218?alt=media&token=d31aecc1-c08d-4f2c-a950-033e7e61b865"),
    Match(name: "Katy", profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/cardsmatchfirebase-1a9ac.appspot.com/o/images%2F1D93F3D3-88C4-4FD2-96E9-BAF9626E6312?alt=media&token=fde1c4a4-bc53-42e1-beed-7fa12717fb4e")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    collectionView.backgroundColor = .white
    // Отсуп внутрь
    collectionView.contentInset = .init(top: heightNavBar, left: 0, bottom: 0, right: 0)
    // Внешний отсуп
//    collectionView.contentOffset = .init(x: 0, y: heightNavBar)
    registerCell()
    setUPCustomNavBar()
    
    fetchMatches()

  }
  
  private func registerCell() {
    collectionView.register(MessagesCell.self, forCellWithReuseIdentifier: messagesCellID)
    collectionView.register(TopCell.self, forCellWithReuseIdentifier: matchCellID)
  }
  
  
  
  // MARK: SetUP View
  
  private func setUPCustomNavBar() {
    
    let customNavBar = CustomNavBar()
    
    view.addSubview(customNavBar)
    customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .zero,size: .init(width: 0, height: heightNavBar))
    
    customNavBar.didTapBackButton = didTapBackButton
    
  }
  
  // MARK: Cells
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    if section == 0 {
      return 1
    } else {
      return 5
    }

  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    if indexPath.section == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: matchCellID, for: indexPath) as! TopCell
      
      cell.horizintalController.items = matchArray
      cell.horizintalController.collectionView.reloadData()
      
      return cell
    } else {

      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: messagesCellID, for: indexPath) as! MessagesCell

      return cell
    }
    
  }
  
  // MARK: NetworkLayer
  
  private func fetchMatches() {
    FetchService.fetchMatches { (result) in
      switch result {
      case.failure(let error):
        print(error.localizedDescription)
      case .success(let data):
        self.matchArray = data
        self.collectionView.reloadData()
      }
    }
  }
  
  
  // MARK: Handle BackButton
  
  private func didTapBackButton() {
    navigationController?.popViewController(animated: true)
  }
  
  
}

extension MessagesController: UICollectionViewDelegateFlowLayout {
  
  // Размер ячеек
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.section == 0 {
      return .init(width: view.frame.width, height: 120)
    } else {

      return .init(width: view.frame.width - 20, height: 150)
    }
    
  }
  
  // Отсуп между секциями
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 10, left: 0, bottom: 0, right: 0)
  }
  
}
