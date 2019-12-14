//
//  LoggedInRouter.swift
//  RibsSample
//
//  Created by 山田隼也 on 2019/12/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

// LoggedInのRIBはViewを持たないので親のRootのViewをもつ
protocol LoggedInViewControllable: ViewControllable {
    func present(viewControllable: ViewControllable)
    func dismiss(viewControllable: ViewControllable)
    func replaceRoot(viewControllable: ViewControllable)
}

//  Viewを持たないので、親のViewを持つ
extension RootViewController: LoggedInViewControllable {}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
    
    // MARK: Private

    private let viewController: LoggedInViewControllable
    
    private let offGameBuilder: OffGameBuildable

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         offGameBuilder: OffGameBuildable) {
        self.viewController = viewController
        
        // 子となるRIB
        self.offGameBuilder = offGameBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
        attachOffGame()
    }
    
    func cleanupViews() {
//        if let currentChild = currentChild {
//            viewController.dismiss(viewController: currentChild.viewControllable)
//        }
    }
}

extension LoggedInRouter {
    
    private func attachOffGame() {
        let offGame = offGameBuilder.build(withListener: interactor)
        attachChild(offGame)
        viewController.replaceRoot(viewControllable: offGame.viewControllable)
    }
}
