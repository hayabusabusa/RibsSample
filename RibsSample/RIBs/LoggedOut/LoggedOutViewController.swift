//
//  LoggedOutViewController.swift
//  RibsSample
//
//  Created by Yamada Shunya on 2019/12/13.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

// VCでユーザーのアクションで発生するイベントはここに書く
// Interactorに処理はとんでいく.
protocol LoggedOutPresentableListener: class {
    func login(name: String?, password: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    weak var listener: LoggedOutPresentableListener?
    
    // MARK: - Lifecycle
    
    static func instantiate() -> LoggedOutViewController {
        let vc = Storyboard.LoggedOutViewController.instantiate(LoggedOutViewController.self)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Presentable

extension LoggedOutViewController {
    
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Setup

extension LoggedOutViewController {
    
    func setupView() {
        loginButton.rx.tap.asSignal()
            .emit(onNext: { [unowned self] in
                self.listener?.login(name: self.nameTextField.text,
                                     password: self.passwordTextField.text)
            })
            .disposed(by: disposeBag)
    }
}
