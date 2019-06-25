//
//  RegisterViewController.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/25.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit
import SnapKit

import ReactiveKit

extension LLRegisterViewController: LLHeaderViewProtocol {}
extension LLRegisterViewController: Loadable {}

final class LLRegisterViewController: LLViewController {
    
    private let viewModel = LLRegisterViewModel()
    
    private let width = ALScreen.width * 0.8
    
    private let formViewHeight: CGFloat = 60.0

    /// ScrollView Top offset when user click each form view
    private lazy var updateConstraintsBase = -(formViewHeight + offset)
        
    private lazy var scrollView: LLScrollView = {
        let sv = LLScrollView()
        sv.delegate = self
        return sv
    }()
    
    private lazy var nameView: LLLoginFormView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: formViewHeight))
        return LLLoginFormView(frame: frame, data: viewModel.getNameFormModel())
    }()
    
    private let btnMale: LLGenderButton = {
        return LLGenderButton(title: "男", isSelected: true)
    }()
    
    private let btnFemale: LLGenderButton = {
        return LLGenderButton(title: "女", isSelected: false)
    }()
    
//    private let calendarView: LLCalendarViewController = {
//        return LLCalendarViewController(startDate: Date(timeIntervalSince1970: 0), endDate: Date())
//    }()
    
    private lazy var emailView: LLLoginFormView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: formViewHeight))
        return LLLoginFormView(frame: frame, data: viewModel.getEmailFormModel())
    }()
    
    private let iconCalendar: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icon_calendar"))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var passwordView: LLLoginFormView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: formViewHeight))
        return LLLoginFormView(frame: frame, data: viewModel.getPasswordFormModel())
    }()
    
    private lazy var passwordConfirmView: LLLoginFormView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: formViewHeight))
        return LLLoginFormView(frame: frame, data: viewModel.getPasswordConfirmFormModel())
    }()
    
    private lazy var phoneView: LLLoginFormView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: formViewHeight))
        return LLLoginFormView(frame: frame, data: viewModel.getPhoneFormModel())
    }()
    
    private let confirmButton: LLButton = {
        return LLButton(title: "下一步", imageName: "icon_next", semantic: .forceRightToLeft)
    }()
   
    private let btnCalendar: UIButton = {
        let btn = UIButton()
        btn.setTitle("YYYY/MM/DD", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 2.0
        return btn
    }()
    
    private let lblBirthday: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "生日"
        return lbl
    }()
    
    private let lblGender: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "性別"
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let iconBirthday: UIImageView = {
        return UIImageView(image: UIImage(named: "icon_star1"))
    }()
    
    private let iconGender: UIImageView = {
        return UIImageView(image: UIImage(named: "icon_star"))
    }()
    
    private lazy var genderButtonWidth: CGFloat = {
        return (width - CGFloat(offset)) / 2
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "加入會員"
        setupViews()
        setupEvents()
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.updateContentView()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        /// Header View
        let headerView = getHeaderView(CGRect(x: 0, y: 0, width: ALScreen.width, height: ALScreen.width * 3 / 4), title: "資料填寫", imageName: "member_header")
        scrollView.addSubview(headerView)
        
        /// Name
        scrollView.addSubview(nameView)
        nameView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(offset)
            make.width.equalTo(width)
            make.height.equalTo(74.0)
        }
        
        /// Gender ImageView
        scrollView.addSubview(iconGender)
        iconGender.snp.makeConstraints { (make) in
            make.leading.equalTo(nameView)
            make.width.height.equalTo(22.0)
            make.top.equalTo(nameView.snp.bottom).offset(offset)
        }

        /// Gender Title
        scrollView.addSubview(lblGender)
        lblGender.snp.makeConstraints { (make) in
            make.leading.equalTo(iconGender.snp.trailing).offset(4.0)
            make.top.equalTo(iconGender)
        }
    
        /// Gender Button (Male)
        scrollView.addSubview(btnMale)
        btnMale.snp.makeConstraints { (make) in
            make.leading.equalTo(nameView)
            make.top.equalTo(iconGender.snp.bottom).offset(4.0)
            make.height.equalTo(44.0)
            make.width.equalTo(self.genderButtonWidth)
        }
        
        /// Gender Button (Female)
        scrollView.addSubview(btnFemale)
        btnFemale.snp.makeConstraints { (make) in
            make.leading.equalTo(btnMale.snp.trailing).offset(offset)
            make.top.equalTo(iconGender.snp.bottom).offset(4.0)
            make.height.equalTo(44.0)
            make.width.equalTo(self.genderButtonWidth)
        }
        
        /// Birthday ImageView
        scrollView.addSubview(iconBirthday)
        iconBirthday.snp.makeConstraints { (make) in
            make.leading.equalTo(nameView)
            make.width.height.equalTo(22.0)
            make.top.equalTo(btnMale.snp.bottom).offset(offset)
        }
        
        /// Birthday Title
        scrollView.addSubview(lblBirthday)
        lblBirthday.snp.makeConstraints { (make) in
            make.leading.equalTo(iconBirthday.snp.trailing).offset(4.0)
            make.top.equalTo(iconBirthday)
        }
        
        scrollView.addSubview(btnCalendar)
        btnCalendar.snp.makeConstraints { (make) in
            make.leading.equalTo(nameView)
            make.top.equalTo(lblBirthday.snp.bottom).offset(4.0)
            make.width.equalTo(width - CGFloat(34.0) - CGFloat(offset))
            make.height.equalTo(44.0)
        }
        
        /// Calendar ImageView
        scrollView.addSubview(iconCalendar)
        iconCalendar.snp.makeConstraints { (make) in
            make.leading.equalTo(btnCalendar.snp.trailing).offset(offset)
            make.centerY.equalTo(btnCalendar)
            make.width.height.equalTo(34.0)
        }

        /// Email
        scrollView.addSubview(emailView)
        emailView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(btnCalendar.snp.bottom).offset(offset)
            make.width.equalTo(width)
            make.height.equalTo(74.0)
        }
        
        /// Password
        scrollView.addSubview(passwordView)
        passwordView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailView.snp.bottom).offset(offset)
            make.width.equalTo(width)
            make.height.equalTo(74.0)
        }
        
        /// Password Confirm
        scrollView.addSubview(passwordConfirmView)
        passwordConfirmView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordView.snp.bottom).offset(offset)
            make.width.equalTo(width)
            make.height.equalTo(74.0)
        }
        
        /// Phone
        scrollView.addSubview(phoneView)
        phoneView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordConfirmView.snp.bottom).offset(offset)
            make.width.equalTo(width)
            make.height.equalTo(74.0)
        }
        
        /// Confirm Button
        scrollView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneView.snp.bottom).offset(offset * 2)
            make.width.equalTo(width)
            make.height.equalTo(44.0)
        }
    }
    
    /// FIXME: 所有會員相關的 offset 的值需要再精算
    private func setupEvents() {
        nameView.beginEditing { [weak self] in
            guard let self = self else { return }
            self.scrollView.updateConstraints(offset: self.updateConstraintsBase)
        }
        
        nameView.finishEditing { [weak self] text in
            guard let self = self else { return }
            self.viewModel.name.value = text
            self.scrollView.updateConstraints(offset: 0.0)
        }
        
        _ = btnMale.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.isFemale.value = false
        }
        
        _ = btnFemale.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.isFemale.value = true
        }
        
        _ = btnCalendar.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] _ in
                guard let self = self else { return }
                self.showCalendarView()
        }
        
        _ = iconCalendar.reactive.tapGesture()
            .observeNext { [weak self] _ in
                guard let self = self else { return }
                self.showCalendarView()
        }
        
        emailView.beginEditing { [weak self] in
            guard let self = self else { return }
            self.scrollView.updateConstraints(offset: self.updateConstraintsBase * 5)
        }

        emailView.finishEditing { [weak self] text in
            guard let self = self else { return }
            if self.viewModel.isRightEmailFormat(with: text) {
                self.viewModel.email.value = text
                self.passwordView.textfield.becomeFirstResponder()
            } else {
                self.showAlertView(Configuration.Context.wrongEmailFormat,
                                    message: "",
                                    confirm: Configuration.Context.confirm)
            }
        }
        
        passwordView.beginEditing { [weak self] in
            guard let self = self else { return }
            self.scrollView.updateConstraints(offset: self.updateConstraintsBase * 6)
        }
    
        passwordView.finishEditing { [weak self] _ in
            guard let self = self else { return }
            if self.viewModel.isPasswordOverSixCharacter() {
                self.passwordConfirmView.textfield.becomeFirstResponder()
            } else {
                self.showAlertView(Configuration.Context.passwordWrongLenght,
                                    message: "",
                                    confirm: Configuration.Context.confirm)
            }
        }
        
        passwordConfirmView.beginEditing { [weak self] in
            guard let self = self else { return }
            self.scrollView.updateConstraints(offset: self.updateConstraintsBase * 7)
        }
        
        passwordConfirmView.finishEditing { [weak self] text in
            guard let self = self else { return }
            if self.viewModel.isPasswordConfrimSame() {
                self.viewModel.password.value = text
                self.phoneView.textfield.becomeFirstResponder()
            } else {
                self.showAlertView(Configuration.Context.passwordNotSame,
                                    message: "",
                                    confirm: Configuration.Context.confirm)
            }
        }
        
        phoneView.beginEditing { [weak self] in
            guard let self = self else { return }
            self.scrollView.updateConstraints(offset: self.updateConstraintsBase * 8)
        }
        
        phoneView.finishEditing { [weak self] text in
            guard let self = self else { return }
            self.prepareToMakeRequest()
            self.viewModel.phone.value = text
        }
        
        _ = confirmButton.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] _ in
                guard let self = self else { return }
                self.prepareToMakeRequest()
        }
    }
    
    /// Setup bindings
    private func setupBindings() {
        viewModel.name
            .bidirectionalBind(to: nameView.textfield.reactive.text)
        viewModel.email
            .bidirectionalBind(to: emailView.textfield.reactive.text)
        viewModel.password
            .bidirectionalBind(to: passwordView.textfield.reactive.text)
        viewModel.passwordConfirm
            .bidirectionalBind(to: passwordConfirmView.textfield.reactive.text)
        viewModel.phone
            .bidirectionalBind(to: phoneView.textfield.reactive.text)
        viewModel.isFemale
            .bind(to: btnFemale.reactive.isSelected)
        viewModel.isFemale
            .map { $0 == false }
            .bind(to: btnMale.reactive.isSelected)
    }
    
    /// Prepare to make request
    private func prepareToMakeRequest() {
        if viewModel.isDoneFillup() {
            scrollView.updateConstraints(offset: 0.0)
            startLoading(at: view.center, onTopOf: view)
            makeRequest()
        } else {
            showAlertView(Configuration.Context.title,
                            message: Configuration.Context.enterComplete,
                            confirm: Configuration.Context.confirm)
        }
    }

    /// Make request
    private func makeRequest() -> Void {
        viewModel.requestAPI() { [weak self] (response) in
            self?.stopLoading()
            guard let self = self else { return }
            
            if let user = response as? LLUserManager.Infos {
                LLUserManager.share.login(value: user)
            }
            
            if let error = response as? APIError {
                self.showAlertView(Configuration.Context.title,
                                    message: error.message ?? "",
                                    confirm: Configuration.Context.confirm)
            }
        }
    }

    /// Show date while user select the date from calendar
    ///
    /// - Parameter sender: date thats user selected
    private func showCalendarView() {
//        present(with: calendarView)
//        calendarView.onFinish = { [weak self] date in
//            guard let self = self else { return }
//            self.btnCalendar.setTitleColor(.black, for: .normal)
//            let date = self.viewModel.convert(from: date)
//            self.btnCalendar.setTitle(date, for: .normal)
//            self.viewModel.birthday.value = date
//        }
    }
}

// ******************************************
//
// MARK: - UIScrollViewDelegate
//
// ******************************************

extension LLRegisterViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}

// ******************************************
//
// MARK: - UITouch Delegate
//
// ******************************************

extension LLRegisterViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// cf. https://stackoverflow.com/questions/6906246/how-do-i-dismiss-the-ios-keyboard
        if !self.isEditing {
            self.scrollView.updateConstraints(offset: 0.0)
            self.view.endEditing(true)
        }
    }
}
