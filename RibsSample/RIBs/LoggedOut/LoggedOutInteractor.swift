//
//  LoggedOutInteractor.swift
//  RibsSample
//
//  Created by Yamada Shunya on 2019/12/13.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import RIBs
import RxSwift

// RouterとやりとりをするためのProtocol
protocol LoggedOutRouting: ViewableRouting {
    
}

// VCとやり取りするためのProtocol
protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    
    func presentAlert(message: String)
}

// 他のRIBとやり取りするためのProtocol
protocol LoggedOutListener: class {
    // 親RIB(Root)に伝える処理
    func didLogin(name: String, password: String)
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {

    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoggedOutPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

extension LoggedOutInteractor {
    
    func login(name: String?, password: String?) {
        if let name = name,
            let password = password,
            !name.isEmpty && !password.isEmpty {
            // Listener経由で親RIBにアクセス
            listener?.didLogin(name: name, password: password)
        } else {
            // presentable経由でVCにアクセス
            presenter.presentAlert(message: "未入力の項目があります。")
        }
    }
}
