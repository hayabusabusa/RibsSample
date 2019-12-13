//
//  RootBuilder.swift
//  RibsSample
//
//  Created by Yamada Shunya on 2019/12/13.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// LoggedOutBuilderを作成するために必要な親から子への依存関係
protocol RootDependencyLoggedOut: Dependency {
    
}

extension RootComponent: LoggedOutDependency {
    
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController.instantiate()
        let interactor = RootInteractor(presenter: viewController)
        
        // 子のRIBのBuilderを作成
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)

        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          loggedOutBuilder: loggedOutBuilder)
    }
}
