//
//  ViewController.swift
//  CardsCourse
//
//  Created by PavelM on 10/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit
import JGProgressHUD
import Firebase

class MainController: UIViewController {
  
  
  
  let fethProgressHUD:JGProgressHUD = {
    let jgc = JGProgressHUD(style: .dark)
    jgc.textLabel.text = "Fething Data"
    return jgc
  }()
  
  var user: User!
  var lastFetchUser: User?
  var mainView: MainView?
  
  var topCardView: CardView?
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.isHidden = true

    view.backgroundColor = .white
    
    configureMainView()
    
    fetchCurrentUser()
    
    
  }
  
  // DIDFinish LoginClouser
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    print("MainController didAppear")
    // Проверка Залогинены мы сейчас или нет
    if Auth.auth().currentUser == nil {
      let loginController = LoginController()
      
      loginController.didFinishLogInClouser = { [weak self] in
        self?.fetchCurrentUser()
      }
      
      let navController = UINavigationController(rootViewController: loginController)
      present(navController, animated: true, completion: nil)
    }
    
  }
  
  // MARK: SET Up Layer
  
  private func configureMainView() {
    
    mainView = MainView()
    
    mainView?.didTapMoreInfoButtonClouser = didTapMoreInfoButton
    
    setTopButtonIbserver()
    setBottomObserver()
    
    view = mainView
  }
  
  private func setTopButtonIbserver() {
    mainView?.topStackView.handleSettingsButtonClouser = handleSettingsButton
    mainView?.topStackView.didTapMessageButton = didTapMessagesButton
  }
  
  private func setBottomObserver() {
    mainView?.bottomStackView.refreshButton.addTarget(self, action: #selector(handleRefreshButton), for: .touchUpInside)
    mainView?.bottomStackView.likeButton.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
    mainView?.bottomStackView.dismissButton.addTarget(self, action: #selector(handleDislikeButton), for: .touchUpInside)
  }
  
  private func presentMatchView(cardUID: String) {
    
    let matchView = MatchView()
    matchView.cardUID = cardUID
    matchView.currentUser = user
    mainView?.addSubview(matchView)
    matchView.fillSuperview()
  }
  
  
  
  
  // MARK: Handel Top Buttons
  
  private func didTapMessagesButton() {
    let vc = MessagesController(collectionViewLayout: UICollectionViewFlowLayout())
    navigationController?.pushViewController(vc, animated: true)
    
  }
  
  private func handleSettingsButton() {
    
    let settingsController = SettingsController()
    
    settingsController.didSaveUserData = { [weak self] in
      self?.fetchCurrentUser()
    }
    
    let naviGationController = UINavigationController(rootViewController: settingsController)
    present(naviGationController, animated: true)
    
  }
  
  // MARK: Handle MoreInfoButtonClouser
  
  private func didTapMoreInfoButton(cardViewModel: CardViewModel) {
    
    let userDetailsController = UserDetailsViewController()
    userDetailsController.cardViewModel = cardViewModel
    
    present(userDetailsController, animated: true, completion: nil)
  }
  
  // MARK: handle Bottom Buttons
  
  @objc private func handleRefreshButton() {
    print("refresh")
    mainView?.cardDeckView.subviews.forEach {$0.removeFromSuperview()}
    fetchCurrentUser()
  }
  
  @objc private func handleLikeButton() {
    print("Like Button")
    saveSwipeToFirestore(like: 1)
    
    //Сначала обновим новый Top Card потом удалим текущий
    guard let cardView = topCardView else {return}
    topCardView = cardView.nextCardView
    // Здесь также делается remove cardView
    CardViewAnimator.performSwipeAnimation(duration: 0.5, transition: 700, angle: 15, cardView: cardView)
    
    
  }
  
  @objc private func handleDislikeButton() {
    print("DisLike Button")
    
    saveSwipeToFirestore(like: 0)
    
    guard let cardView = topCardView else {return}
    topCardView = cardView.nextCardView
    // Здесь также делается remove cardView
    CardViewAnimator.performSwipeAnimation(duration: 0.5, transition: -700, angle: -15, cardView: cardView)
    
  }
  
  private func didDismissCardView(like: Int) {
    
    if like == 0 {
      handleDislikeButton()
    } else {
      handleLikeButton()
    }
    
  }
  
  // MARK: NEtwork Layer
  
  // MARK: Save Swipe To Firestore
  private func saveSwipeToFirestore(like: Int) {
    
    guard let cardUID = topCardView?.cardViewModel.uid else {return}
    
    SaveService.saveSwipeToFirestore(cardUID: cardUID,like:like) { (result) in
      switch result {
      case .failure(let error):
        self.showAlert(title: "Ошибка Swipe", message: error.localizedDescription)
        
      case .success(_):
        print("Сохранение swipe прошло успешно")
        if like == 1 {
          self.checkInMatchExist(cardUID:cardUID)
        }
        
      }
    }
    
  }
  
  // MARK: it IS MAtch
  
  private func checkInMatchExist(cardUID: String) {
    // Запрашиваем документы из коллекции Юзера и проверям поставил он нашему ID = 1 или 0
    Firestore.firestore().collection(CollectionKey.swipes.rawValue).document(cardUID).getDocument{ (snapshot, error) in
      if let error = error {
        print("Fetch Dociment from checkInMatchExist")
      }
      guard let data = snapshot?.data() else {return}
      let userMatchMe = data[NetworkService.currentUserID ?? ""] as? Int
      
      if userMatchMe == 1 {
        
        self.presentMatchView(cardUID:cardUID)
//        let matchController = MatchController(matchView: MatchView())
//        self.present(matchController, animated: true)
        
      }
      
    }
  }
  
  // MARK: fetchCurrentUser
  private func fetchCurrentUser() {
    
    fethProgressHUD.show(in: view)
    
    // Очищаем карточки чтобы накачать заново!
    mainView?.cardDeckView.subviews.forEach {$0.removeFromSuperview()}
    
    // Сначала загрузим свои данные
    FetchService.fetchCurrentUserFromFirestore { (result) in
      switch result {
      case .failure(let error):
        self.showAlert(title: "Ошибка загрузки Своих Данных", message: error.localizedDescription)
        
      case .success(let userDict):
        self.user = User(dictionary: userDict)
        // Потом идут все пользователи
        
        // Сначала получим всех данные из коллекции swipe потом подгрузим и отобразим 
        self.fetchSwipes()
  
      }
    }
    
  }
  
  var swipes = [String: Int]()
  
  private func fetchSwipes() {
    
    FetchService.fetchSwipes { (result) in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      case .success(let data):
         self.swipes = data
      }
      self.fetchUsersFromFireStore()
    }

  }
  
  // MARK: Fetch Users
  
  private func fetchUsersFromFireStore() {
    
    // Запрос с порядком следования
    //    order:UserKey.userId.rawValue,after: lastFetchUser?.userID ?? "", limit: 2
    
    let minAge = user.minSeekingAge ?? SettingsController.defaultMinSeekingAge
    let maxAge = user.maxSeekingAge ?? SettingsController.defaultMaxSeekingAge
    
    // делаем связанный список чтобы 1 Карта ссыллалсь на другую
    var previousCardView: CardView?
    topCardView = nil
    
    FetchService.fetchUsersFromFirestore(minAge: minAge, maxAge: maxAge) {(result) in
      switch result {
      case .failure(let error):
        print(error)
        
      case .success(let userDictionary):
        
        self.fethProgressHUD.dismiss()
        let user = User(dictionary: userDictionary)
        
        let isNotCurrentUser = user.userID != NetworkService.currentUserID
        
        
        // Короче не показывай тех кого я уже отметил! Like
        let hasNotSwipedBefore = self.swipes[user.userID!] == nil
        // Пока отключу это дело потом надо будет подставить
        if isNotCurrentUser  {
    
          let cardView = self.mainView?.setUPCardFromUser(user: user)
          
          cardView?.dismissCardClouser = self.didDismissCardView
          
          // Linked List
          previousCardView?.nextCardView = cardView
          previousCardView = cardView
          
          if self.topCardView == nil {
            print("topCardView")
            // Это самая верхняя карта! Самая первая
            self.topCardView = cardView
            
          }
        }
        
      }
    }
    
  }
  
  
  
  
  
}

