//
//  RootRouter.swift
//  RibsSample
//
//  Created by Yamada Shunya on 2019/12/13.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import RIBs

// LoggedOut のリスナーを追加した
// 関心のある子RIBのリスナーを追加する必要がある？
protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // VCにして欲しいこと
    func present(viewControllable: ViewControllable)
    func dismiss(viewControllable: ViewControllable)
}

/// アプリのRootとなるRouter
///
/// `LaunchRouter`に準拠させる.
///
final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let loggedOutBuilder: LoggedOutBuilder
    private var loggedOut: ViewableRouting?
    
    private let loggedInBuilder: LoggedInBuildable
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuilder,
         loggedInBuilder: LoggedInBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        // Attach でRIBを子供としてアクティブにする
        attachChild(loggedOut)
        
        // VCに処理を実行してもらう
        viewController.present(viewControllable: loggedOut.viewControllable)
    }
}

extension RootRouter {
    
    func routeToLoggedIn(name: String, password: String) {
        // デタッチしてViewを閉じる
        if let loggedOut = loggedOut {
            detachChild(loggedOut)
            viewController.dismiss(viewControllable: loggedOut.viewControllable)
            self.loggedOut = nil
        }
        let loggedIn = loggedInBuilder.build(withListener: interactor)
        attachChild(loggedIn)
    }
}
