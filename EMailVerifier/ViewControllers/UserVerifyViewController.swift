//
//  UserVerifyViewController.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import RxCocoa
import RxSwift

import UIKit

class UserVerifyViewController: UIViewController {

    var viewModel: UserVerifyViewModel?
    
    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var verifyButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Verification"
        setupBindings()
        setupObservers()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    private func setupBindings() {
        
        guard let viewModel = viewModel else { return }
        
        tokenTextField.rx
            .text
            .orEmpty
            .bind(to: viewModel.token)
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
        
        verifyButton.rx
            .tap
            .subscribe(onNext: {
                viewModel.onVerifyButtonTap()
            })
            .disposed(by: disposeBag)
    }
}
