//
//  OffGameViewController.swift
//  RibsSample
//
//  Created by 山田隼也 on 2019/12/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol OffGamePresentableListener: class {
    func startGame()
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var startButton: UIButton!
    
    // MARK: Properties

    weak var listener: OffGamePresentableListener?
    private let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    
    static func instantiate() -> OffGameViewController {
        let vc = Storyboard.OffGameViewController.instantiate(OffGameViewController.self)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Setup

extension OffGameViewController {
    
    private func setupViews() {
        startButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.listener?.startGame()
            })
            .disposed(by: disposeBag)
    }
}

extension OffGameViewController {
    
    func present(viewControllable: ViewControllable) {
        let vc = viewControllable.uiviewController
        present(vc, animated: true, completion: nil)
    }
}
