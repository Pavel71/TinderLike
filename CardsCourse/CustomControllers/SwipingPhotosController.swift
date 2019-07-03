//
//  SwipingPhotosController.swift
//  CardsCourse
//
//  Created by PavelM on 26/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit
import SDWebImage

class SwipingPhotosController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  
  
  
  var cardViewModel: CardViewModel! {
    
    didSet {
      // Убираем из списка пустые поля
      let clearImages = cardViewModel.imageNames.filter{!$0.isEmpty}

      controllers = clearImages.map({ (urlString) -> UIViewController in
        return PhotoController(imageURL: urlString)
      })

      setViewControllers([controllers.first!], direction: .forward, animated: false)
      
      setUpBarViews(count: clearImages.count)

    }
  }
  
  var controllers = [UIViewController]()
  private var barStackView: TopBarView!
  
  private let isCardViewMode: Bool
  
  init(isCardViewMode: Bool = false) {
    self.isCardViewMode = isCardViewMode
    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
  }
  

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    delegate = self
    view.backgroundColor = .white
    
    if isCardViewMode {
      disableSwipingAbility()
    }
    
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecogniser)))
  }
  
  private func disableSwipingAbility() {
    view.subviews.forEach { (v) in
      if let v = v as? UIScrollView {
        v.isScrollEnabled = false
      }
    }
  }
  
  // MARK: HandleTapGestureRecogniser
  
  @objc private func handleTapGestureRecogniser(gesture: UITapGestureRecognizer) {
    
    let tapLocation = gesture.location(in: nil)
    
    let shouldAdvanceNextPhoto = tapLocation.x > view.frame.width / 2 ? true : false
    
    let currentController = (viewControllers?.first)!
    
    if let index = self.controllers.firstIndex(of: currentController) {
      
      var nextIndex: Int!
      if shouldAdvanceNextPhoto {
        nextIndex = min(index + 1, controllers.count - 1)
      } else {
        nextIndex = max(index - 1, 0)
      }
      swipeImage(nextIndex:nextIndex)
    }
    
  }
  
  private func swipeImage(nextIndex: Int) {
    
    barStackView.selectBar(index: nextIndex)
    let nextController = controllers[nextIndex]
    setViewControllers([nextController], direction: .forward, animated: false)
  }
  
  private func setUpBarViews(count: Int) {

    barStackView = TopBarView(frame: .zero, count: count)
    
    // Не используем safeLayout Gaide так как из за него прыгает barstackview
    var paddingTop: CGFloat = 8
    
    if !isCardViewMode {
      // Нужен этот отступ вместо использования safeLayoutGade
      paddingTop += UIApplication.shared.statusBarFrame.height
    }
    
    view.addSubview(barStackView)
    barStackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: paddingTop, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 5))
    
    
  }
  
  
  // MARK: PAgeController DataSource
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
  
    let index = self.controllers.firstIndex(of: viewController as! PhotoController) ?? -1
    
    barStackView.selectBar(index: index)
    
    if index == controllers.count - 1 {return nil}
    return controllers[index + 1]
  }
  
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
 
    let index = self.controllers.firstIndex(of: viewController as! PhotoController) ?? -1
    
    barStackView.selectBar(index: index)

    if index == 0 {
      return nil
    } else {
      return controllers[index - 1]
    }
    

  }
  
  // MARK: PageController Delegate
  // Когда заканчивается анимация!
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    
    // Вообщем тут оверкода! Проще так как я сделал!
//    let currentController = (viewControllers?.first)!
//    let index = controllers.firstIndex(of: currentController)
    
    print("Page transitoion Completed")
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}

// MARK: PhotController ImageView

class PhotoController: UIViewController {
  
  let imageView = UIImageView()
  
  init(imageURL: String) {
    super.init(nibName: nil, bundle: nil)
    guard let url = URL(string: imageURL) else {return}
    imageView.sd_setImage(with: url)

  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(imageView)
    imageView.fillSuperview()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
