//
//  OffGameRouter.swift
//  RibsSample
//
//  Created by 山田隼也 on 2019/12/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import RIBs

protocol OffGameInteractable: Interactable, TicTacToeListener {
    var router: OffGameRouting? { get set }
    var listener: OffGameListener? { get set }
}

protocol OffGameViewControllable: ViewControllable {
    func present(viewControllable: ViewControllable)
}

final class OffGameRouter: ViewableRouter<OffGameInteractable, OffGameViewControllable>, OffGameRouting {

    private let ticTacToeBuilder: TicTacToeBuildable
    
    init(interactor: OffGameInteractable,
         viewController: OffGameViewControllable,
         ticTacToeBuilder: TicTacToeBuildable) {
        self.ticTacToeBuilder = ticTacToeBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension OffGameRouter {
    
    func routeToTicTacToe() {
        let ticTacToe = ticTacToeBuilder.build(withListener: interactor)
        viewController.present(viewControllable: ticTacToe.viewControllable)
    }
}
