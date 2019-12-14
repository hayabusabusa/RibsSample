//
//  RootComponent+LoggedOut.swift
//  RibsSample
//
//  Created by 山田隼也 on 2019/12/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import RIBs

// LoggedOutBuilderを作成するために必要な親から子への依存関係
protocol RootDependencyLoggedOut: Dependency {
    
}

extension RootComponent: LoggedOutDependency {
    
}
