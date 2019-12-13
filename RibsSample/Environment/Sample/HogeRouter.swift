//
//  HogeRouter.swift
//  RibsSample
//
//  Created by Yamada Shunya on 2019/12/13.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import RIBs

protocol HogeInteractable: Interactable {
    var router: HogeRouting? { get set }
    var listener: HogeListener? { get set }
}

protocol HogeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class HogeRouter: ViewableRouter<HogeInteractable, HogeViewControllable>, HogeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: HogeInteractable, viewController: HogeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
