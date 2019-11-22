//
//  UserRegistrationViewController.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import RxSwift
import RxCocoa
import UIKit

class UserRegistrationViewController: UIViewController {

    var viewModel: UserRegistrationViewModel?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var registerButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBindings()
        setupObservers()
        title = "User Registration"
        
        // Since we are in dev mode we do not need content type. For a production app we will have to use the cotent type
        // to .newPassword or .password
        // https://developer.apple.com/documentation/security/password_autofill/setting_up_an_app_s_associated_domains
        passwordTextField.textContentType = .none
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        
        emailTextField.rx
            .text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx
            .text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
    }
    
    private func setupObservers() {
        
        guard let viewModel = viewModel else { return }
        
        viewModel.hasError
            .asObserver()
            // Inverting the value
            .map{!$0}
            .observeOn(MainScheduler.instance)
            .bind(to: errorLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .asObserver()
            .observeOn(MainScheduler.instance)
            .bind(to: errorLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.showLoading
            .asObserver()
            .observeOn(MainScheduler.instance)
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        registerButton.rx
            .tap
            .subscribe(onNext: {
                viewModel.onRegisterButtonTap()
            })
            .disposed(by: disposeBag)
    }
}
