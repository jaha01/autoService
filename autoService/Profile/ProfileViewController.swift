//
//  ProfileViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 29.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Public properties
    
    var interactor: ProfileInteractor!
    
    // MARK: - Private properties
    
    private let photoView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var photo: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "welcome_4")
        image.layer.cornerRadius = 90
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let email: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Почта"
        textfield.isUserInteractionEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let phone: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Телефон"
        textfield.isUserInteractionEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let name: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Имя"
        textfield.isUserInteractionEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let city: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Город"
        textfield.isUserInteractionEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        //        textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textfield
    }()
    
    private let experience: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Стаж"
        textfield.isUserInteractionEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let birthday: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Дата Рождения"
        textfield.isUserInteractionEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let brand: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Марка"
        textfield.isUserInteractionEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self, action: #selector(chouseCarBrand), for: .editingDidBegin)
        return textfield
    }()
    
    private let model: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Модель"
        textfield.isUserInteractionEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let year: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Год выпуска"
        textfield.isUserInteractionEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let volume: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Объем"
        textfield.isUserInteractionEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let mileage: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Пробег"
        textfield.isUserInteractionEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isScrollEnabled = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let personLabel: UILabel = {
        let label = UILabel()
        label.text = "Owner info"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let carLabel: UILabel = {
        let label = UILabel()
        label.text = "Car info"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let birthdayDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        return datePicker
    }()
    
    private let experienceDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        return datePicker
    }()
    
    private let modelYearDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        return datePicker
    }()
    
    // MARK: - Public method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemGray4
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(didTapEdit))
        
        setupViews()
        setupConstraints()
        interactor.onViewDidLoad()
        CarsModelViewController().delegate = self
    }
    
    func showErrorAlert(config: AlertConfig) {
        AlertManager.showAlert(config: config)
    }
    
    func setProfileData(item: ProfileInfo) {
        email.text = item.email
        phone.text = item.phone
        name.text = item.name
        city.text = item.city
        experience.text = item.experience
        birthday.text = item.birthday
        brand.text = item.brand
        model.text = item.model
        year.text = item.year
        volume.text = item.volume
        mileage.text = item.mileage
    }
    
    // MARK: - Private methods
    @objc private func didTapLogout() {
        interactor.didTapSignOut()
    }
    
    @objc private func didTapEdit() {
        let profileInputs = [email,
                             phone,
                             name,
                             city,
                             experience,
                             birthday,
                             brand,
                             model,
                             year,
                             volume,
                             mileage
                            ]
        for input in profileInputs {
            input.isUserInteractionEnabled.toggle()
        }
        if email.isUserInteractionEnabled {
            navigationItem.leftBarButtonItem?.title = "Done"
        } else {
            navigationItem.leftBarButtonItem?.title = "Edit"
            saveInfo()
        }
    }
    
    @objc private func chouseCarBrand(_ textField: UITextField) {
        interactor.showCarsBrand()
    }
    
    private func saveInfo() {
        print("saveInfo  self.brand.text = \(self.brand.text!)")
        let info = ProfileInfo(email: email.text!,
                           phone: phone.text!,
                           name: name.text!,
                           city: city.text!,
                           experience: experience.text!,
                           birthday: birthday.text!,
                           brand: brand.text!,
                           model: model.text!,
                           year: year.text!,
                           volume: volume.text!,
                           mileage: mileage.text!)
        
        interactor.updateProfileInfo(info: info)
    }
    
    @objc private func birthdayHandleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        birthday.text = dateFormatter.string(from: sender.date)
    }
    
    @objc private func experienceHandleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        experience.text = dateFormatter.string(from: sender.date)
    }
    
    @objc private func yearHandleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        year.text = dateFormatter.string(from: sender.date)
    }
    
    @objc private func datePickerDone() {
        birthday.resignFirstResponder()
        experience.resignFirstResponder()
        year.resignFirstResponder()
    }
    
    private func setupViews() {
        view.addSubview(photoView)
        view.addSubview(scrollView)
        photoView.addSubview(photo)
        scrollView.addSubview(email)
        scrollView.addSubview(phone)
        scrollView.addSubview(name)
        scrollView.addSubview(city)
        scrollView.addSubview(experience)
        scrollView.addSubview(birthday)
        scrollView.addSubview(brand)
        scrollView.addSubview(model)
        scrollView.addSubview(year)
        scrollView.addSubview(volume)
        scrollView.addSubview(mileage)
        scrollView.addSubview(personLabel)
        scrollView.addSubview(carLabel)
        
        birthday.inputView = birthdayDatePicker
        experience.inputView = experienceDatePicker
        year.inputView = modelYearDatePicker
        
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        birthdayDatePicker.addTarget(self, action: #selector(birthdayHandleDatePicker(sender:)), for: .valueChanged)
        birthday.inputAccessoryView = toolBar
        experienceDatePicker.addTarget(self, action: #selector(experienceHandleDatePicker(sender:)), for: .valueChanged)
        experience.inputAccessoryView = toolBar
        modelYearDatePicker.addTarget(self, action: #selector(yearHandleDatePicker(sender:)), for: .valueChanged)
        year.inputAccessoryView = toolBar
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            
            scrollView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            photo.centerXAnchor.constraint(equalTo: photoView.centerXAnchor),
            photo.centerYAnchor.constraint(equalTo: photoView.centerYAnchor),
            photo.heightAnchor.constraint(equalToConstant: 180),
            photo.widthAnchor.constraint(equalToConstant: 180),
            
            personLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            personLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            personLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            personLabel.bottomAnchor.constraint(equalTo: personLabel.topAnchor, constant: 20),
            
            email.topAnchor.constraint(equalTo: personLabel.bottomAnchor, constant: 16),
            email.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            email.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            email.bottomAnchor.constraint(equalTo: email.topAnchor, constant: 48),
            
            phone.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 16),
            phone.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            phone.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            phone.bottomAnchor.constraint(equalTo: phone.topAnchor, constant: 48),
            
            name.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: 16),
            name.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            name.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            name.leadingAnchor.constraint(equalTo: name.leadingAnchor, constant: 48),
            
            city.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 16),
            city.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            city.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            city.bottomAnchor.constraint(equalTo: city.topAnchor, constant: 48),
            
            experience.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 16),
            experience.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            experience.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            experience.bottomAnchor.constraint(equalTo: experience.topAnchor, constant: 48),
            
            birthday.topAnchor.constraint(equalTo: experience.bottomAnchor, constant: 16),
            birthday.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            birthday.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            birthday.bottomAnchor.constraint(equalTo: birthday.topAnchor, constant: 48),
            
            carLabel.topAnchor.constraint(equalTo: birthday.bottomAnchor, constant: 16),
            carLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            carLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            carLabel.bottomAnchor.constraint(equalTo: carLabel.topAnchor, constant: 20),
            
            brand.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: 16),
            brand.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            brand.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            brand.bottomAnchor.constraint(equalTo: brand.topAnchor, constant: 48),
            
            model.topAnchor.constraint(equalTo: brand.bottomAnchor, constant: 16),
            model.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            model.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            model.bottomAnchor.constraint(equalTo: model.topAnchor, constant: 48),
            
            year.topAnchor.constraint(equalTo: model.bottomAnchor, constant: 16),
            year.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            year.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            year.bottomAnchor.constraint(equalTo: year.topAnchor, constant: 48),
            
            volume.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 16),
            volume.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            volume.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            volume.bottomAnchor.constraint(equalTo: volume.topAnchor, constant: 48),
            
            mileage.topAnchor.constraint(equalTo: volume.bottomAnchor, constant: 16),
            mileage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            mileage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            mileage.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
}


// MARK: - CarsModelViewControllerDelegate implementation
extension ProfileViewController: CarsModelViewControllerDelegate {
    func chosen(brand: String) {
        self.brand.text = brand // это часть не присваивается, хотся brand не nil
    }
}
