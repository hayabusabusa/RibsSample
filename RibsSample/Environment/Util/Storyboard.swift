//
//  Storyboard.swift
//  RibsSample
//
//  Created by Yamada Shunya on 2019/12/13.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case RootViewController
    case LoggedOutViewController
    case OffGameViewController
    case TicTacToeViewController
    
    func instantiate<VC: UIViewController>(_ : VC.Type, inBundle: Bundle? = nil) -> VC {
        guard let vc = UIStoryboard(name: self.rawValue, bundle: inBundle).instantiateInitialViewController() as? VC else {
            fatalError("Couldn`t instantiate \(self.rawValue)")
        }
        return vc
    }
}
