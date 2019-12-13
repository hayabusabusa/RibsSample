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
protocol RootInteractable: Interactable, LoggedOutListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // VCにして欲しいこと
    func present(viewControllable: ViewControllable)
}

/// アプリのRootとなるRouter
///
/// `LaunchRouter`に準拠させる.
///
final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let loggedOutBuilder: LoggedOutBuilder
    private var lggedOut: ViewableRouting?
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuilder) {
        self.loggedOutBuilder = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.lggedOut = loggedOut
        // Attach でRIBを子供としてアクティブにする
        attachChild(loggedOut)
        
        // VCに処理を実行してもらう
        viewController.present(viewControllable: loggedOut.viewControllable)
    }
}
