//
//  MatchCollectionViewController.swift
//  CardsCourse
//
//  Created by PavelM on 02/07/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class MatchHorizontalController: UICollectionViewController {
  
  init() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    super.init(collectionViewLayout: layout)
    collectionView.decelerationRate = .fast
    collectionView.backgroundColor = .white
  }
  
  var items = [Match]()
  
  let cellID = "cellID"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    
    registerCell()
  }
  
  private func registerCell() {
    collectionView.register(MatchCell.self, forCellWithReuseIdentifier: cellID)
  }
  
  
  
  
  // MARK: Cell
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MatchCell
    
    cell.item = items[indexPath.row]
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MatchHorizontalController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width / 3, height: view.frame.height)
  }
}
