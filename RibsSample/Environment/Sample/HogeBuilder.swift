//
//  HogeBuilder.swift
//  RibsSample
//
//  Created by Yamada Shunya on 2019/12/13.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import RIBs

protocol HogeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class HogeComponent: Component<HogeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol HogeBuildable: Buildable {
    func build(withListener listener: HogeListener) -> HogeRouting
}

final class HogeBuilder: Builder<HogeDependency>, HogeBuildable {

    override init(dependency: HogeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HogeListener) -> HogeRouting {
        //let component = HogeComponent(dependency: dependency)
        let viewController = HogeViewController()
        let interactor = HogeInteractor(presenter: viewController)
        interactor.listener = listener
        return HogeRouter(interactor: interactor, viewController: viewController)
    }
}
