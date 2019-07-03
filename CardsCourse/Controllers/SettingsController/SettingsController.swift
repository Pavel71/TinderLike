//
//  SettingsController.swift
//  CardsCourse
//
//  Created by PavelM on 17/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit
import SDWebImage
import JGProgressHUD
import Firebase



class SettingsController: UITableViewController {
  
  static let defaultMinSeekingAge = 18
  static let defaultMaxSeekingAge = 50
  var didSaveUserData: (() -> Void)?
  
  weak var selectButton: UIButton!
  // Как вариант еще создать CustomImagePicker and var imageButton
  // Чтобы использовать пикер в делегате!
  
  
  var user: User?
  var header = HeaderView()
  
  let jgcSaveHUD: JGProgressHUD = {
    let jcg = JGProgressHUD(style: .dark)
    jcg.textLabel.text = "Save Data"
    return jcg
  }()
  
  let jcgUpLoadHUD:JGProgressHUD  = {
    let jcg = JGProgressHUD(style: .dark)
    jcg.textLabel.text = "Upload image in Storage..."
    return jcg
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavController()
    configureNavigationBar()
    configureTableView()
    
    
    loadUserData()
  }
  
  // MARK: 1. LoadUserData
  
  private func loadUserData() {
    
    FetchService.fetchCurrentUserFromFirestore { (result) in
      
      switch result {
      case .failure(let error):
        print(error)
        
      case .success(let userData):
        self.user = User(dictionary: userData)
        
        self.loadUserPhotos()
        self.tableView.reloadData()
      }
      
    }
  }
  
  private func loadUserPhotos() {
    
    guard let imageStringArray = user?.imageURlArray else {return}
    
    
    for (index,url) in imageStringArray.enumerated() {
      
      guard let imageURL = URL(string: url) else {return}
      // Сохраняет в Кэш! Поэтому повторная загрузка будет быстрой!
      SDWebImageManager.shared.loadImage(with: imageURL, options: .continueInBackground, progress: nil) { (image, _, _, _, _, _) in
        
        let imageButtons = self.header.getImageButtons()
        imageButtons[index].setImage(
          image?.withRenderingMode(.alwaysOriginal),
          for: .normal)
      }
    }
    
    
    
  }
  
  private func configureTableView() {
    tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    tableView.tableFooterView = UIView()
    tableView.keyboardDismissMode = .interactive
  }
  
  private func setNavController() {
    
    navigationItem.title = "Settings"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 6
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 0 : 1
  }
  
  // MARK: Cell
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = SettingsTableViewCell(style: .default, reuseIdentifier: nil)
    
    
    switch indexPath.section {
    case 1:
      
      configureTextFiedlInSettingCell(cell: cell, placeHolder: "Enter Name", text: user?.name ?? "", tag: 1)
    case 2:

      configureTextFiedlInSettingCell(cell: cell, placeHolder: "Enter Proffession", text: user?.profession ?? "", tag: 2)
    case 3:

      if let age = user?.age {
        configureTextFiedlInSettingCell(cell: cell, placeHolder: "Enter Age", text: "\(age)", tag: 3,keyboardType: .numberPad)
      } else {
        configureTextFiedlInSettingCell(cell: cell, placeHolder: "Enter Age", text: "", tag: 3,keyboardType: .numberPad)
      }
      
    case 4:
      cell.textField.placeholder = "Enter Bio"
      
    default:
      let ageRangeCell = AgeRangeCell()
      configureAgeRangeCell(cell:ageRangeCell)
      
      return ageRangeCell
      
    }
    return cell
  }
  
  // MARK: 2. ConfigureTableView Cell
  
  private func configureTextFiedlInSettingCell(cell: SettingsTableViewCell, placeHolder: String, text: String, tag: Int, keyboardType: UIKeyboardType = .default) {
    
    cell.textField.placeholder = placeHolder
    cell.textField.text = text
    cell.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    cell.textField.tag = tag
    cell.textField.keyboardType = keyboardType
  }
  
  
  
  private func configureAgeRangeCell(cell: AgeRangeCell) {
    // Set Observer Slider
    let minSeekingAge = user?.minSeekingAge ?? SettingsController.defaultMinSeekingAge
    cell.minSlider.value = Float(minSeekingAge)
    cell.minLabel.text = "Min: \(minSeekingAge)"
    
    let maxSeekingAge = user?.maxSeekingAge ?? SettingsController.defaultMaxSeekingAge
    cell.maxSlider.value = Float(maxSeekingAge)
    cell.maxLabel.text = "Max: \(maxSeekingAge)"

    
    cell.minSlider.addTarget(self, action: #selector(sliderValueChange), for: .valueChanged)
    cell.maxSlider.addTarget(self, action: #selector(sliderValueChange), for: .valueChanged)
  }
  
  // MARK: Slider ValueChange
  
  @objc private func sliderValueChange(slider: UISlider) {

    let indexPath = IndexPath(row: 0, section: 5)
    let ageRangeCell = tableView.cellForRow(at: indexPath) as! AgeRangeCell
    let valueInt = Int(slider.value)
    
    let maxSeekingAge = self.user!.maxSeekingAge!
    let minSeekingAge = self.user!.minSeekingAge!
    
    if slider.tag == 0 { // Slider Min

      
      if valueInt <= maxSeekingAge {
        setMinSeekingAge(cell: ageRangeCell, value: valueInt)
        
      } else {
        setMinSeekingAge(cell: ageRangeCell, value: valueInt)

        ageRangeCell.maxSlider.value = slider.value
        setMaxSeekingAge(cell: ageRangeCell, value: valueInt)
      }

      
    } else { // Slider Max
      
      if valueInt >= minSeekingAge {
        setMaxSeekingAge(cell: ageRangeCell, value: valueInt)
      } else {
        
        ageRangeCell.maxSlider.value = Float(minSeekingAge)
      }

    }

  }
  
  private func setMinSeekingAge(cell: AgeRangeCell,value: Int) {
    cell.minLabel.text = "Min: \(value)"
    self.user?.minSeekingAge = value
  }
  
  private func setMaxSeekingAge(cell: AgeRangeCell,value: Int) {
    cell.maxLabel.text = "Max: \(value)"
    self.user?.maxSeekingAge = value
  }
  

  
  
  // MARK: TextChange
  @objc fileprivate func textFieldDidChange(textField: UITextField) {
    
    switch textField.tag {
    case 1:
      user?.name = textField.text
    case 2:
      user?.profession = textField.text
    case 3:
      user?.age = Int.init(textField.text!)
      
    default:
      print("deff")
    }
  }
  
  
  
}



extension SettingsController {
  
  // MARK: NavigationBar Configure
  
  fileprivate func configureNavigationBar() {
    
    
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelButton))
    
    let logOutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogOutButton))
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveButton))
    navigationItem.leftBarButtonItem = cancelButton
    navigationItem.rightBarButtonItems = [saveButton,logOutButton]
  }
  
  // MARK: Handle NavButtons
  
  @objc fileprivate func handleCancelButton() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc fileprivate func handleLogOutButton() {
    
    let logBool = LoginService.logOut()
    
    if !logBool {
      showAlert(title: "Ошибка", message: "Ошибка Разлогинивания")
    }
    dismiss(animated: true)
  }
  

  
  @objc fileprivate func handleSaveButton() {
    
    jgcSaveHUD.show(in: view)
    
    SaveService.saveSettingsDataInFireStore(user: user!) { (result) in
      switch result {
      case .failure(let error):
        self.showAlert(title: "Ошибка обновления данных", message: error.localizedDescription)
      case .success(_):
        print("Сохранение прошло успешно")
        self.jgcSaveHUD.dismiss()
        
        self.dismiss(animated: true, completion: {
          // Нужно с помощью делегата передать данные!
          // или же я могу использовать clouser
          
          self.didSaveUserData!()

          
        })
        
      }
    }
  }
}





// MARK: Top Header and Header in Section

extension SettingsController {
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    if section == 0 {
      
      header.handleSelectPhotoClouser = selectPhotoHeader
      
      return header
    }
    
    return configureHeaderLabel(section: section)
  }
  
  func configureHeaderLabel(section: Int) -> UIView {
    
    let headerlabel = Headerlabel()
    
    switch section {
    case 1:
      headerlabel.text = "Name"
    case 2:
      headerlabel.text = "Proffesion"
    case 3:
      headerlabel.text = "Age"
    case 4:
      headerlabel.text = "BIO"
    default:
      headerlabel.text = "Age Range"
      
    }
    
    headerlabel.font = UIFont.boldSystemFont(ofSize: 20)
    return headerlabel
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
    return section == 0 ? 200 : 40
  }
  
  func selectPhotoHeader(button: UIButton) {
    
    selectButton = button
    setImagePicker()
  }
}


// MARK: ImagePicker
extension SettingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  fileprivate func setImagePicker() {
    
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    present(imagePickerController, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    let image = info[.originalImage] as? UIImage
    selectButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    dismiss(animated: true, completion: nil)
    
    // Пропишим сохранение изображения в Storage и сохранение его URL в FireStore
    guard let img = image else {return}
    saveImageInStorage(image: img)
  }
  
  // MARK: Save Image in FireStore
  
  private func saveImageInStorage(image: UIImage) {
    
    jcgUpLoadHUD.show(in: view)
    
    SaveService.saveImageInStorage(image: image) { (result) in
      switch result {
      case .failure(let error):
        self.showAlert(title: "Ошибка загрузки Изображение", message: error.localizedDescription)
      case .success(let url):
        self.jcgUpLoadHUD.dismiss()
        
        let indexImage = self.selectButton.tag
        print(indexImage)
        self.user?.imageURlArray?[indexImage] = "\(url)"
        
      }
    }
  }
  
}

// MARK: Header Label
class Headerlabel: UILabel {
  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.insetBy(dx: 16, dy: 0))
  }
}
